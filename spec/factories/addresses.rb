# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  address     :string
#  city        :string
#  state       :string
#  postal_code :string
#  country     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :address do
    address "MyString"
city "MyString"
state "MyString"
postal_code "MyString"
country "MyString"
  end

end
