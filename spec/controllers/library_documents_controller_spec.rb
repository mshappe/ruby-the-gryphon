require 'rails_helper'

RSpec.describe LibraryDocumentsController, type: :controller do
  let(:document1) { create :library_document, title: "Fishbait" }

  describe 'GET #show' do
    before :each do
      get :show, id: document1.id
    end

    it 'should succeed for everyone' do
      expect(response).to be_success
    end
  end

  describe 'GET #search' do
    before do
      get :search, q: { title_cont: 'bait' }
    end

    it 'should succeed and return a document in the list' do
      expect(response).to be_success
      expect(assigns[:library_documents]).to include document1
    end
  end
end