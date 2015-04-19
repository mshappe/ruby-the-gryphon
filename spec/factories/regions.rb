# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :region do
    sequence(:name) { Faker::Name.name }
    description "MyText"
  end

end
