# frozen_string_literal: true

# == Schema Information
#
# Table name: authorization_types
#
#  id                       :integer          not null, primary key
#  name                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  martial_activity_type_id :integer
#
# Indexes
#
#  index_authorization_types_on_martial_activity_type_id  (martial_activity_type_id)
#

FactoryBot.define do
  factory :authorization_type do
    name { 'MyString' }
  end
end
