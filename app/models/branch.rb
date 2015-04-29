# == Schema Information
#
# Table name: branches
#
#  id                           :integer          not null, primary key
#  name                         :string
#  branch_type_id               :integer
#  region_id                    :integer
#  map_coordinates              :string
#  parent_branch_id             :integer
#  city                         :string
#  state                        :string
#  url                          :string
#  active                       :boolean
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  branch_heraldry_file_name    :string
#  branch_heraldry_content_type :string
#  branch_heraldry_file_size    :integer
#  branch_heraldry_updated_at   :datetime
#  map_image_file_name          :string
#  map_image_content_type       :string
#  map_image_file_size          :integer
#  map_image_updated_at         :datetime
#
# Indexes
#
#  index_branches_on_branch_type_id  (branch_type_id)
#  index_branches_on_name            (name) UNIQUE
#  index_branches_on_region_id       (region_id)
#

class Branch < ActiveRecord::Base
  has_paper_trail
  resourcify
  has_attached_file :branch_heraldry, storage: :database, cascade_deletion: true
  has_attached_file :map_image, storage: :database, cascade_deletion: true

  belongs_to :branch_type
  belongs_to :region
  belongs_to :parent_branch, class_name: 'Branch', foreign_key: 'parent_branch_id'
  has_many :child_branches, class_name: 'Branch', inverse_of: :parent_branch

  validates :name, presence: true, uniqueness: true
  validates :branch_type, presence: true
  validates :region, presence: true
  validates_attachment_content_type :branch_heraldry, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :map_image, :content_type => /\Aimage\/.*\Z/

end
