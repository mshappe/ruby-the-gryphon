require 'rails_helper'

RSpec.shared_examples 'a management controller' do
  describe "get #index" do
    describe 'anonymous' do
      it 'redirect tp root' do
        get :index
        expect(response).to be_redirect
      end
    end

    describe 'not admin' do
      login_user

      it 'redirect to root' do
        get :index
        expect(response).to be_redirect
      end
    end

    describe 'as admin' do
      login_user(:admin)

      it 'should succeed' do
        get :index
        expect(response).to be_success
      end
    end
  end
end
