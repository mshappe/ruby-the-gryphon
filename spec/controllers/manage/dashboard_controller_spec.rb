require 'rails_helper'

RSpec.describe Manage::DashboardController, type: :controller do
  it_behaves_like "a management controller"

  describe 'get #index as admin' do
    login_user :admin

    before :each do
      @other_user = create :user
      get :index
    end

    it 'should find various adminable things' do
      expect(assigns(:users)).to match_array User.all
    end
  end
end
