# == Schema Information
#
# Table name: library_sections
#
#  id         :integer          not null, primary key
#  name       :string
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LibrarySection < ActiveRecord::Base
  has_many :library_documents, -> { order :order }
end
