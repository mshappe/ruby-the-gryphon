require 'rails_helper'

RSpec.describe AwardsController, type: :controller do
  before :each do
    @branch = create :branch
    @awards = (0..2).collect do |n|
      create :award, precedence: 3-n, branch: @branch
    end
  end

  describe 'GET #index (without params) for all users' do
    before :each do
      get :index
    end
    it 'should succeed and show awards in precedence order' do
      expect(response).to be_success
      expect(assigns[:awards]).to eq @awards.sort { |x,y| x.precedence <=> y.precedence }
    end
  end
end