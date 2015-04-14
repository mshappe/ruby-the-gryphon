require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do
  describe 'GET :index' do
    before :each do
      get :index
    end

    specify 'It should get the front page' do
      expect(response).to be_success
    end
  end  

end
