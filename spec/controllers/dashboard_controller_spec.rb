require 'rails_helper'

RSpec.describe DashboardController, :type => :controller do

  describe 'GET show' do
    login_user

    before :each do
      get :show, user_id: @user.id
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
      expect(assigns[:events]).to_not be_nil
      expect(assigns[:awards]).to_not be_nil
      expect(assigns[:auths]).to_not be_nil
      expect(assigns[:warrants]).to_not be_nil
    end
  end

end
