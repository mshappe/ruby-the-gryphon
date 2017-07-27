# == Schema Information
#
# Table name: award_recommendations
#
#  id                     :integer          not null, primary key
#  award_id               :integer
#  persona_id             :integer
#  persona_name           :string
#  legal_name             :string
#  branch_id              :integer
#  gender                 :string
#  persona_description    :text
#  is_youth               :boolean
#  sca_term               :integer
#  reason                 :text
#  status                 :string
#  planned_court_id       :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  submitted_by_person_id :integer
#
# Indexes
#
#  index_award_recommendations_on_award_id          (award_id)
#  index_award_recommendations_on_branch_id         (branch_id)
#  index_award_recommendations_on_persona_id        (persona_id)
#  index_award_recommendations_on_planned_court_id  (planned_court_id)
#

require 'rails_helper'

RSpec.describe AwardRecommendationsController, type: :controller do
  describe 'GET #index' do
    before :each do
      @visible_rec = create :award_recommendation
      @hidden_rec = create :award_recommendation, status: AwardRecommendation::STATUS_HIDE
    end
    
    describe 'anonymous user' do
      before :each do
        get :index
      end

      it 'should fail' do
        ap assigns
        expect(response).to redirect_to :root
      end
    end
  end


  describe 'GET #show' do
    let(:rec) { create :award_recommendation }

    describe 'anonymous user' do
      before :each do
        get :show, id: rec.id
      end

      it 'should fail' do
        expect(response).to redirect_to :root
      end
    end

    describe 'common user' do
      login_user

      before :each do
        get :show, id: rec.id
      end

      it 'should fail' do
        expect(response).to redirect_to :root
      end
    end

    describe 'for a rec I submitted' do
      login_user

      before :each do
        rec.update(submitted_by_person_id: @user.person.id)
        get :show, id: rec.id
      end

      it 'should succeed' do
        expect(response).to be_success
      end
    end

    describe 'for royalty' do
      login_user :royalty

      before :each do
        get :show, id: rec.id
      end

      it 'should succeed' do
        expect(response).to be_success
      end
    end

    describe 'for admin' do
      login_user :admin

      before :each do
        get :show, id: rec.id
      end

      it 'should succeed' do
        expect(response).to be_success
      end
    end
  end

  describe 'GET #new' do
    describe 'anonymous user' do
      before :each do
        get :new
      end

      it 'should fail' do
        expect(response).to redirect_to :root
      end
    end

    describe 'logged in user' do
      login_user

      before :each do
        get :new
      end

      it 'should succed' do
        expect(response).to be_success
      end
    end
  end

  describe 'POST #create' do
    let(:rec) { build :award_recommendation }

    describe 'anonymouse user' do
      before :each do
        post :create, award_recommendation: rec.attributes
      end

      it 'should fail' do
        expect(response).to redirect_to :root
      end
    end

    describe 'logged in user' do
      login_user

      describe 'with good params' do
        let(:mail) { double }
        before :each do
          expect(AwardRecommendationNotifier).to receive(:new_recommendation) { mail }
          expect(mail).to receive(:deliver_later)
          post :create, award_recommendation: rec.attributes
        end

        it 'should succeed' do
          expect(assigns[:award_recommendation]).to be_valid
          expect(assigns[:award_recommendation]).to be_persisted
          expect(response).to redirect_to award_recommendation_path(assigns[:award_recommendation].id)
        end
      end

      describe 'with garbage' do
        before :each do
          rec.status = 'Q'
          post :create, award_recommendation: rec.attributes
        end

        it 'should fail' do
          expect(flash[:error]).to match %r[problem]
          expect(response).to render_template :new
        end
      end
    end
  end
end
