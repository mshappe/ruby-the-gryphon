# frozen_string_literal: true

# == Schema Information
#
# Table name: persona_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_persona_types_on_name  (name)
#

FactoryBot.define do
  factory :persona_type do
    sequence(:name) { Faker::Name.name }
  end
end
