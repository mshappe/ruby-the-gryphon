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

FactoryBot.define do
  factory :library_section do
    name { "MyString" }
    sequence(:order) { 1 }
  end
end
