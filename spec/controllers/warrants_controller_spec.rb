require 'rails_helper'

RSpec.describe WarrantsController, type: :controller do
  describe 'GET index' do
    describe 'any user who is an officer' do
      login_user
      let(:officer) { create :person, user: @user }
      let(:subordinate) { create :person }
      let(:go_type) { create :warrant_type }
      let(:so_type) { create :warrant_type, superior_warrant: go_type }
      let!(:go_warrant) { create :warrant, warrant_type: go_type, person: officer }
      let!(:so_warrant) { create :warrant, warrant_type: so_type, person: subordinate }
      let(:random_warrant) { create :warrant }

      before :each do
        get :index
      end

      it 'should see their subordinates' do
        expect(response).to be_success
        expect(assigns[:subordinates].count).to eq 1
        expect(assigns[:subordinates]).to include so_type
        expect(assigns[:warrants]).to include so_warrant
      end
    end

    describe 'a user who is not an officer' do
      login_user

      before :each do
        get :index
      end

      it 'should succeed but be empty' do
        expect(response).to be_success
        expect(assigns[:subordinates].count).to eq 0
      end
    end
  end

  describe 'GET #show' do
    let(:warrant) { create :warrant, submission_state: 'queued' }

    describe 'anonymous' do
      before :each do
        get :show, id: warrant.id
      end

      it 'should redirect and require sign in' do
        expect(response).to be_redirect
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'GET #queued' do
    describe 'logged in' do
      login_user

      describe 'An officer with approval authority' do
        let!(:officer) { create :person, user: @user }
        let!(:subordinate) { create :person }
        
        let!(:warrant) { create :warrant, submission_state: 'queued', person: subordinate }
        let!(:not_it) { create :warrant, submission_state: 'approved', person: subordinate }

        before :each do
          get :queued
        end

        it 'should succeed and returned queued warrants' do
          ap response.code
          expect(response).to be_success
          expect(assigns[:subordinates].count).to eq 1
          expect(assigns[:subordinates]).to include warrant.warrant_type
          expect(assigns[:subordinates].first.warrants).to include warrant
        end
      end
    end
  end

  describe 'GET #new' do
    describe 'anonymous' do
      before :each do
        get :new
      end

      it 'should redirect to require sign in' do
        expect(response).to be_redirect
        expect(response).to redirect_to root_url
        is_expected.to set_flash.to 'Please sign in to make this request!'
      end
    end

    describe 'logged in' do
      login_user

      before :each do
        get :new
      end

      it 'should succeed' do
        expect(response).to be_success
        expect(assigns[:warrant].person_id).to eq @user.person.id
      end
    end
  end

  describe 'GET #create' do
    let(:params) { attributes_for :warrant }
    describe 'anonymous' do
      before :each do
        post :create, warrant: params
      end

      it 'should redirect and require sign in' do
        expect(response).to be_redirect
        expect(response).to redirect_to root_url
      end
    end
  end
end