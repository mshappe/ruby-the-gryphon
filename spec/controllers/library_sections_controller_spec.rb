require 'rails_helper'
RSpec.describe LibrarySectionsController, type: :controller do
  let(:section1) { create :library_section, order: 1 }
  let(:document1) { create :library_document, library_section: section1, order: 2 }
 
  describe 'GET #index' do
    before :each do
      get :index
    end

    it 'should succeed for everyone' do
      expect(response).to be_success
      expect(assigns[:q]).to be_present
      expect(assigns[:library_sections]).to include section1
    end
  end
end