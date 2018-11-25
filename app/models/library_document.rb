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

class LibraryDocument < ActiveRecord::Base
  belongs_to :library_section
  belongs_to :post # Rails 5, optional: true

  has_attached_file :attachment
  validates_attachment :attachment,
    size: { in: 0..300.megabytes },
    allow_blank: true
  do_not_validate_attachment_file_type :attachment
end
