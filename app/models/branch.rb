# == Schema Information
#
# Table name: branches
#
#  id               :integer          not null, primary key
#  name             :string
#  branch_type_id   :integer
#  region_id        :integer
#  branch_heraldry  :string
#  map_image        :string
#  map_coordinates  :string
#  parent_branch_id :integer
#  city             :string
#  state            :string
#  url              :string
#  active           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
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

  belongs_to :branch_type
  belongs_to :region
  belongs_to :parent_branch, class_name: 'Branch', foreign_key: 'parent_branch_id'
  has_many :child_branches, class_name: 'Branch', inverse_of: :parent_branch

  validates :name, presence: true, uniqueness: true
  validates :branch_type, presence: true
  validates :region, presence: true
end
