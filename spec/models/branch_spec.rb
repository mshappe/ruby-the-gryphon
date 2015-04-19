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

require 'rails_helper'

RSpec.describe Branch, :type => :model do
  it { is_expected.to belong_to :branch_type }
  it { is_expected.to belong_to :region }
  it { is_expected.to belong_to :parent_branch }
  it { is_expected.to have_many :child_branches }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to validate_presence_of :branch_type }
  it { is_expected.to validate_presence_of :region }
end
