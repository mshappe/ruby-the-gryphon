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

FactoryBot.define do
  factory :library_document do
    title { "MyString" }
    order { 1 }
    library_section { nil }
    post { nil }
    attachment { "" }
  end
end
