# == Schema Information
#
# Table name: authorization_types
#
#  id         :integer          not null, primary key
#  name       :string
#  group      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :authorization_type do
    name "MyString"
  end

end
