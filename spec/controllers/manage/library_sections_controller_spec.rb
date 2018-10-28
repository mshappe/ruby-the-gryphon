require 'rails_helper'

RSpec.describe Manage::LibrarySectionsController, type: :controller do
  describe '#new' do
    it_behaves_like 'a management controller', :show, :library_section
    it_behaves_like 'a management controller', :new, :library_section
    it_behaves_like 'a management creator', :library_section, name: Faker::Name.name, order: 42
    it_behaves_like 'a management updater', :library_section, { name: Faker::Name.name }, :name
    it_behaves_like 'a management deleter', :library_section
  end
end
