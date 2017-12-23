# == Schema Information
#
# Table name: martial_activity_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_martial_activity_types_on_name  (name)
#

FactoryBot.define do
  factory :martial_activity_type do
    name "MyString"
  end
end
