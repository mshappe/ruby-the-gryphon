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

RSpec.describe LibraryDocument, type: :model do
  it { is_expected.to belong_to :library_section }
  it { is_expected.to belong_to :post }
  it { is_expected.to have_attached_file :attachment }
end
