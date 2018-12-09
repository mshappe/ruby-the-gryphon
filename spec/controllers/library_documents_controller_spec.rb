# == Schema Information
#
# Table name: library_documents
#
#  id                      :integer          not null, primary key
#  title                   :string
#  order                   :integer
#  library_section_id      :integer
#  post_id                 :integer
#  attachment_file_name    :string
#  attachment_content_type :string
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_library_documents_on_library_section_id  (library_section_id)
#  index_library_documents_on_post_id             (post_id)
#

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
