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

FactoryGirl.define do
  factory :drop_down_item do
    name "MyString"
description "MyText"
type ""
active false
  end

end
