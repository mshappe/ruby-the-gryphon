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

class Address < ActiveRecord::Base
  has_paper_trail
  geocoded_by :full_address, lookup: :esri
  reverse_geocoded_by :latitude, :longitude, lookup: :esri do |obj, results|
    if results.try :first
      geo = results.first
      obj.address = geo.address
      obj.city = geo.city
      obj.state = geo.state_code
      obj.postal_code = geo.postal_code
      obj.country = obj.country_code
    end
  end
  after_validation :geocode, if: ->(obj) { obj.changed? }

  has_one :person

  def full_address
    "#{address}, #{city}, #{state} #{postal_code}, #{country}"
  end
end
