require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do
  describe 'GET :index' do
    before :each do
      create :event # We don't need to reference it.
      get :index
    end

    specify 'It should get the front page' do
      expect(response).to be_success
      expect(assigns(:events)).to_not be_nil
    end
  end  

end
