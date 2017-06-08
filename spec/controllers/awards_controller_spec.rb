# == Schema Information
#
# Table name: awards
#
#  id                       :integer          not null, primary key
#  name                     :string
#  description              :text
#  precedence               :integer
#  award_badge_file_name    :string
#  award_badge_content_type :string
#  award_badge_file_size    :integer
#  award_badge_updated_at   :datetime
#  award_type_id            :integer
#  branch_id                :integer
#  active                   :boolean
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_awards_on_award_type_id  (award_type_id)
#  index_awards_on_branch_id      (branch_id)
#

require 'rails_helper'

RSpec.describe AwardsController, type: :controller do
  before :each do
    @branch = create :branch, name: 'B'
    @other_branch = create :branch, name: 'A'

    @awards = (0..2).collect do |n|
      create :award, precedence: 3-n, branch: @branch
    end
    @sorted_awards = @awards.sort { |x,y| x.precedence <=> y.precedence }
    @other_award = create :award, branch: @other_branch

    Rails.application.config.x.branch_name = @branch.name
  end

  after :each do
    Rails.application.config.x.branch_name = nil
    Rails.cache.clear
  end

  context 'GET #index' do
    context 'without params, for all users' do
      before :each do
        get :index
      end
      it 'should succeed and show awards for the defined default branch in precedence order' do
        expect(response).to be_success
        expect(assigns[:awards].count).to eq 3
        expect(assigns[:awards]).to eq @sorted_awards
      end
    end

    context 'with branch=all' do
      before :each do
        get :index, branch: 'all'
      end

      it 'should return all awards in group, then precedence order' do
        expect(response).to be_success
        expect(assigns[:awards].count).to eq 4
        expect(assigns[:awards]).to eq @sorted_awards.prepend @other_award
      end
    end

    context 'with branch selected by id' do
      before :each do
        get :index, branch: { id: @other_branch.id }
      end

      it 'should return the award for that branch' do
        expect(response).to be_success
        expect(assigns[:awards].count).to eq 1
        expect(assigns[:awards]).to eq [@other_award]
      end
    end

    context 'can search' do
      before :each do
        get :index, q: { name_cont: @awards.first.name[0..2] }
      end

      it 'should return the search-for award(s)' do
        expect(response).to be_success
        expect(assigns[:awards].count).to eq 1
        expect(assigns[:awards].first).to eq @awards.first
      end
    end
  end

  context 'GET #show' do
    context 'just an ordinary get' do
      before :each do
        @court = create :court
        @persona = create :persona
        @award_recipient = create :award_recipient, award: @awards.first, persona: @persona, court: @court
      end

      it 'displays award information including recipients in order most to least recent' do
        get :show, id: @awards.first

        expect(response).to be_success
        expect(assigns[:award]).to eq @awards.first
        expect(assigns[:award_recipients]).to match_array [@award_recipient]
      end
    end

    context 'searching' do
      before :each do
        @court1 = create :court
        @court2 = create :court
        @personas1 = create_list :persona, 3
        @personas2 = create_list :persona, 3
        @award_recipients1 = @personas1.collect do |p|
          create :award_recipient, award: @awards.first, persona: p, court: @court1
        end
        @award_recipients2 = @personas2.collect do |p|
          create :award_recipient, award: @awards.first, persona: p, court: @court2
        end
      end

      context 'recipients' do
        before :each do
          get :show, id: @awards.first, q: { persona_name_cont: @personas1[1].name }
        end

        it 'should return just who we want' do
          expect(response).to be_success
          expect(assigns[:award_recipients].count).to eq 1
          expect(assigns[:award_recipients].first).to eq @award_recipients1[1]
        end
      end

      context 'courts' do
        before :each do
          get :show, id: @awards.first, q: { court_event_name_cont: @court1.event.name }
        end

        it 'should return just who we want' do
          expect(response).to be_success
          expect(assigns[:award_recipients].count).to eq 3
          expect(assigns[:award_recipients]).to match_array @award_recipients1
        end

      end
    end
  end

  context 'GET #new' do
    context 'for people who are not cool enough' do
      it 'should not return a new page' do
        get :new
        expect(response).to be_redirect
      end
    end

    context 'for people are cool enough' do
      login_user :admin

      it 'should return a new page' do
        get :new
        expect(response).to be_success
      end
    end
  end

  context 'GET #edit' do
    context 'for people who are not cool enough' do
      it 'should not return an edit page' do
        get :edit, id: @awards.first.id
        expect(response).to be_redirect
      end
    end

    context 'for people who are cool enough' do
      login_user :admin

      it 'should return an edit page for people who are cool enough' do
        get :edit, id: @awards.first.id
        expect(response).to be_success
      end
    end
  end

  context 'POST #create' do
    context 'for people who are not logged in at all' do
      it 'does not post' do
        post :create, award: attributes_for(:award)
        expect(response).to be_redirect
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'for people who are not cool enough' do
      login_user

      it 'does not post' do
        post :create, award: attributes_for(:award)
        expect(response).to be_redirect
        expect(response).to redirect_to root_url
      end
    end

    context 'for the cool kids' do
      login_user :admin

      it 'posts correct' do
        expect { post :create, award: attributes_for(:award) }.to change { Award.count }.by 1
        is_expected.to set_flash[:notice]
        expect(response).to be_redirect
        expect(response).to redirect_to Award.last
      end

      it 'returns to new with bad params' do
        attrs = attributes_for(:award)
        attrs[:name] = nil
        expect { post :create, award: attrs }.to_not change { Award.count }
        is_expected.to set_flash[:error]
        expect(response).to be_success
        expect(response).to render_template :new
      end
    end
  end

  context 'PATCH #update' do
    context 'for people who are not logged in at all' do
      it 'does not put' do
        patch :update, id: @awards.first.id, award: { name: 'Llamaface' }
        expect(response).to be_redirect
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'for people who are not cool enough' do
      login_user

      it 'does not PATCH' do
        patch :update, id: @awards.first.id, award: { name: 'Llamaface' }
        expect(response).to be_redirect
        expect(response).to redirect_to root_url
      end
    end

    context 'for people who are cool enough' do
      login_user :admin

      it 'updates correctly' do
        expect { put :update, id: @awards.first.id, award: { name: 'Llamaface' } }.to change { @awards.first.reload.name }.to eq 'Llamaface'
        is_expected.to set_flash[:notice]
        expect(response).to be_redirect
        expect(response).to redirect_to @awards.first
      end

      it 'returns to edit with bad params' do
        expect { put :update, id: @awards.first.id, award: { name: nil } }.to_not change { @awards.first.reload.name }
        is_expected.to set_flash[:error]
        expect(response).to be_success
        expect(response).to render_template :edit
      end
    end
  end

  context 'DELETE #destroy' do
    login_user :admin

    context 'even for cool kids' do
      it 'raises an exception because we do not allow deletion!' do
        expect { delete :destroy, id: @awards.first.id }.to raise_error ActionController::UrlGenerationError
      end
    end
  end
end
