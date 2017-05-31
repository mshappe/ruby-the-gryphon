# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  name                 :string
#  start_at             :datetime
#  end_at               :datetime
#  url                  :string
#  branch_id            :integer
#  sponsor_branch_id    :integer
#  unlisted_host        :string
#  unlisted_sponsor     :string
#  site_name            :string
#  address_id           :integer
#  web_ad               :text
#  comments             :text
#  admin_comments       :text
#  submitter_persona_id :integer
#  submitter_sca_name   :string
#  submitter_legal_name :string
#  submitter_phone      :string
#  submitter_email      :string
#  steward_persona_id   :integer
#  steward_sca_name     :string
#  steward_legal_name   :string
#  steward_phone        :string
#  steward_email        :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  submission_state     :string
#  supersedes_id        :integer
#  superseded_by_id     :integer
#
# Indexes
#
#  index_events_on_address_id            (address_id)
#  index_events_on_branch_id             (branch_id)
#  index_events_on_sponsor_branch_id     (sponsor_branch_id)
#  index_events_on_steward_persona_id    (steward_persona_id)
#  index_events_on_submission_state      (submission_state)
#  index_events_on_submitter_persona_id  (submitter_persona_id)
#

require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  before :each do
    @unapproved_event = create :event, start_at: Date.tomorrow, submission_state: 'queued'
    @good_event = create :event, start_at: Date.tomorrow, submission_state: 'approved'
    @old_event = create :event, start_at: 2.days.ago, submission_state: 'approved'
    @future_event = create :event, start_at: 4.months.from_now, submission_state: 'approved'
  end

  describe 'GET #index (without params) for all users' do
    before :each do
      get :index
    end
    it 'should succeed just fine and show only future events by default' do
      expect(response).to be_success
      expect(assigns[:events]).to match_array [@good_event, @future_event]
    end
  end

  describe 'GET #index(include: :past) for all users' do
    before :each do
      get :index, include: 'past'
    end
    it 'should succeed just fine and show all approved events' do
      expect(response).to be_success
      expect(assigns[:events]).to match_array [@good_event, @old_event, @future_event]
    end
  end

  describe 'GET #queued' do
    describe 'for visitors' do
      it 'should fail' do
        get :queued
        expect(response).to redirect_to root_url
      end
    end

    describe 'for event officer' do
      login_user :event_officer

      it 'should succeed' do
        get :queued
        expect(response).to be_success
      end
    end
  end

  describe 'GET #show for all users' do
    describe 'for an approved event' do
      before :each do
        get :show, id: @good_event.id
      end

      it 'should succeed' do
        expect(response).to be_success
      end
    end

    describe 'for an unapproved event' do
      specify 'should fail' do
        get :show, id: @unapproved_event.id
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'GET #new' do
    describe 'for visitors' do
      it 'should fail' do
        get :new
        expect(response).to redirect_to root_url
      end
    end

    describe 'for users' do
      login_user

      it 'should succeed' do
        get :new
        expect(response).to be_success
      end
    end

  end

  describe 'POST #create' do
    describe 'for visitors' do
      specify 'should fail' do
        post :create, event: attributes_for(:event)
        expect(response).to redirect_to root_url
      end
    end

    describe 'for users' do
      login_user

      specify 'should succeed, object should be queued' do
        expect { post :create, event: attributes_for(:event, submitter_persona_id: @user.personas.first.id) }.to change { ActionMailer::Base.deliveries.count }.by 1
        expect(response).to redirect_to event_url Event.last
        is_expected.to set_flash.to 'Event submitted. It will be reviewed by the Event Information Officer.'
        expect(assigns[:event].submission_state).to eq 'queued'
      end

      specify 'should force state to queued if it is anything other than queued' do
        expect { post :create, event: attributes_for(:event, submission_state: 'approved', submitter_persona_id: @user.personas.first.id) }.to change { ActionMailer::Base.deliveries.count }.by 1
        expect(response).to redirect_to event_url Event.last
        is_expected.to set_flash.to 'Event submitted. It will be reviewed by the Event Information Officer.'
        expect(assigns[:event].submission_state).to eq 'queued'
      end
    end
  end

  describe 'GET #edit' do
    describe 'for visitors' do
      let(:event) { create :event }
      specify 'should fail' do
        get :edit, id: event.id
        expect(response).to redirect_to root_url
      end
    end

    describe 'for users' do
      login_user
      describe 'editing their own event' do
        let(:event) { create :event, submitter_persona: @user.personas.first }
        it 'should succeed but with an unpersisted copy in queued state' do
          get :edit, id: event.id
          expect(response).to be_success
          expect(assigns[:event]).to_not be event
          expect(assigns[:event].submission_state).to eq 'queued'
          expect(assigns[:event]).to_not be_persisted
        end
      end

      describe "editing someone else's event" do
        let(:event) { create :event }
        it 'should fail' do
          get :edit, id: event.id
        end
      end
    end

    describe 'for event information officers' do
      login_user(:event_officer)
      describe 'editing any event' do
        let(:event) { create :event }
        it 'should succeed like a normal edit' do
          get :edit, id: event.id
          expect(response).to be_success
          expect(assigns[:event]).to eq event
        end
      end
    end
  end

  describe 'PATCH #update' do
    describe 'for visitors' do
      let(:event) { create :event }

      it 'should fail' do
        patch :update, id: event.id, event: { name: 'Foo' }
        expect(response).to redirect_to root_url
      end
    end

    describe 'for users' do
      login_user
      let(:event) { create :event, submitter_persona: @user.personas.first }

      it 'should fail -- users cannot update directly' do
        patch :update, id: event.id, event: { name: 'Foo' }
        expect(response).to redirect_to root_url
      end
    end

    describe 'for event officers' do
      login_user(:event_officer)
      let(:event) { create :event, submitter_persona: create(:persona) }

      it 'should succeed' do
        patch :update, id: event.id, event: { name: 'Foo' }
        expect(response).to redirect_to event
        is_expected.to set_flash.to 'Event updated. Submitter will be notified.'
      end

      describe 'approving a superseding event' do
        before do
          @successor = event.dup
          @successor.submission_state = 'queued'
          @successor.supersedes = event
          @successor.save!
          event.submission_state = 'approved'
          event.superseded_by = @successor
          event.save!

          patch :update, id: @successor.id, event: { submission_state: 'approved' }
          event.reload
          @successor.reload
        end

        it 'should retire event and save successor' do
          expect(response).to redirect_to @successor
          is_expected.to set_flash.to 'Event updated. Submitter will be notified.'
          expect(event.submission_state).to eq 'retired'
          expect(@successor.submission_state).to eq 'approved'
        end
      end
    end
  end

end
