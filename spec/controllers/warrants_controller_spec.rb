require 'rails_helper'

RSpec.describe WarrantsController, type: :controller do
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