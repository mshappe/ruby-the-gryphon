# frozen_string_literal: true

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
#  index_branches_on_branch_type_id    (branch_type_id)
#  index_branches_on_name              (name)
#  index_branches_on_parent_branch_id  (parent_branch_id)
#

FactoryBot.define do
  factory :branch do
    sequence(:name) { Faker::Name.name }
    association :branch_type
    association :region
    map_coordinates { 'MyString' }
    parent_branch_id { nil }
    city { 'MyString' }
    state { 'MyString' }
    url { 'MyString' }
    active { false }
  end
end
