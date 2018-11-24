require 'rails_helper'

RSpec.describe Manage::LibraryDocumentsController, type: :controller do
  describe do
    it_behaves_like 'a management controller', :show, :library_document
    it_behaves_like 'a management controller', :edit, :library_document
    it_behaves_like 'a management creator', :library_document, title: Faker::Name.name, order: 42
    it_behaves_like 'a management updater', :library_document, { title: Faker::Name.name }, :title
    it_behaves_like 'a management deleter', :library_document

    describe "get :new" do
      let(:library_section) { create :library_section }
      let(:thing) { create :library_document, library_section: library_section }

      describe 'anonymous' do
        it 'redirect to root' do
          get :new, id: thing.id, library_section_id: library_section.id
          expect(response).to be_redirect
        end
      end

      describe 'not admin' do
        login_user

        it 'redirect to root' do
          get :new, id: thing.id, library_section_id: library_section.id
          expect(response).to be_redirect
        end
      end

      describe 'as admin' do
        login_user(:admin)

        it 'should succeed' do
          get :new, id: thing.id, library_section_id: library_section.id
          expect(response).to be_success
        end
      end
    end
    describe 'PUT #remove_attachment' do
      login_user(:admin)
      let(:doc) { create :library_document, attachment: File.new(Rails.root + 'spec/fixtures/govdocs.pdf') }

      before do
        put :remove_attachment, id: doc.id
      end

      it 'should succeed and remove attachment' do
        doc.reload
        expect(response).to be_redirect
        expect(response).to redirect_to edit_manage_library_document_path(doc)
        expect(doc.attachment.present?).to be_falsey
      end
    end

  end
end
