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

FactoryGirl.define do
  factory :branch do
    sequence(:name) { Faker::Name.name }
    branch_type
    region
    branch_heraldry "MyString"
    map_image "MyString"
    map_coordinates "MyString"
    parent_branch_id 1
    city "MyString"
    state "MyString"
    url "MyString"
    active false
  end

end
