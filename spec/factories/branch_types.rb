# == Schema Information
#
# Table name: branch_types
#
#  id          :integer          not null, primary key
#  name        :string
#  full_status :boolean
#  has_award   :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :branch_type do
    sequence(:name) { Faker::Name.name }
    full_status { true }
    has_award { false }
  end

end
