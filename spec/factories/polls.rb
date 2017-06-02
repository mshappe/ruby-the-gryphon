# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  question   :text
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :poll do
    question "MyText"
    active false
  end
end
