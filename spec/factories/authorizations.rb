# == Schema Information
#
# Table name: authorizations
#
#  id                    :integer          not null, primary key
#  person_id             :integer
#  authorization_type_id :integer
#  date_of               :datetime
#  notes                 :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_authorizations_on_authorization_type_id  (authorization_type_id)
#  index_authorizations_on_person_id              (person_id)
#

FactoryBot.define do
  factory :authorization do
    user nil
authorization_type nil
date_of "2016-02-18 11:53:41"
notes "MyText"
  end

end
