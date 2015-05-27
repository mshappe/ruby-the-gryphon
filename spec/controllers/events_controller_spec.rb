require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  before :each do
    Event.destroy_all # I have no idea where the stray event is coming from and I don't care.
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
        expect(response).to redirect_to new_user_session_url
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
        expect(response).to redirect_to new_user_session_url
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
        expect(response).to redirect_to new_user_session_url
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
        expect(response).to redirect_to new_user_session_url
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