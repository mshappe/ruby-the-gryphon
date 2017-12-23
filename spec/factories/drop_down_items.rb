# == Schema Information
#
# Table name: drop_down_items
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  type        :string
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :drop_down_item do
    sequence(:name) { Faker::Name.name }
    description "MyText"
    active false
  end

  factory :region, parent: :drop_down_item, class: RegionType do
    active true
  end

  factory :post_type, parent: :drop_down_item, class: PostType do
    active true
  end
end
