# == Schema Information
#
# Table name: sca_memberships
#
#  sca_number   :string           primary key
#  sca_exp_date :datetime
#
# Indexes
#
#  index_sca_memberships_on_sca_number  (sca_number)
#

FactoryGirl.define do
  factory :sca_membership do
    sca_number "MyString"
    sca_exp_date "2017-06-02 13:48:55"
  end
end
