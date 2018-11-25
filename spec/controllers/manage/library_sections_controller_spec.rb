require 'rails_helper'

RSpec.describe Manage::LibrarySectionsController, type: :controller do
  describe do
    it_behaves_like 'a management controller', :show, :library_section
    it_behaves_like 'a management controller', :new, :library_section
    it_behaves_like 'a management controller', :edit, :library_section
    it_behaves_like 'a management creator', :library_section, name: Faker::Name.name, order: 42
    it_behaves_like 'a management updater', :library_section, { name: Faker::Name.name }, :name
    it_behaves_like 'a management deleter', :library_section
  end

  describe 'Also for #show' do
    let(:section) { create :library_section }
    let(:documents) { create_list :library_document, 3, library_section: section }

    login_user :admin

    before :each do
      get :show, id: section.id
    end

    it 'should have a q and a list of docs' do
      expect(assigns).to have_key :library_documents_q
      expect(assigns).to have_key :library_documents
      expect(assigns[:library_documents]).to match_array documents
    end
  end
end
