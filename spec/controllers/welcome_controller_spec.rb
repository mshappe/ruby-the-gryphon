# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET :index' do
    before :each do
      create :event, submission_state: 'approved' # We don't need to reference it.
      type = create :post_type, name: 'Announcement'
      create :post, post_type: type, start_date: 1.second.ago, approved: 1.second.ago
      get :index
    end

    specify 'It should get the front page' do
      expect(response).to be_success
      expect(assigns(:events)).to_not be_empty
      expect(assigns(:posts)).to_not be_empty
    end
  end
end
