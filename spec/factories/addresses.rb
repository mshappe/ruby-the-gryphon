# frozen_string_literal: true

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
#  latitude    :float
#  longitude   :float
#
# Indexes
#
#  index_addresses_on_latitude_and_longitude  (latitude,longitude)
#

FactoryBot.define do
  factory :address do
    address { 'MyString' }
    city { 'MyString' }
    state { 'MN' }
    postal_code { '55423' }
    country { 'US' }
  end
end
