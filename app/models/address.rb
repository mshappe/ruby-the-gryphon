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

class Address < ActiveRecord::Base
  has_one :person
end
