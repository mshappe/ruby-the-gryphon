require 'rails_helper'

RSpec.describe Manage::LibraryDocumentsController, type: :controller do
  describe do
    it_behaves_like 'a management controller', :show, :library_document
    it_behaves_like 'a management controller', :new, :library_document
    it_behaves_like 'a management controller', :edit, :library_document
    it_behaves_like 'a management creator', :library_document, title: Faker::Name.name, order: 42
    it_behaves_like 'a management updater', :library_document, { title: Faker::Name.name }, :title
    it_behaves_like 'a management deleter', :library_document
  end
end
