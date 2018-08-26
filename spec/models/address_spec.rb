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

require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to have_one :person }
  it { is_expected.to respond_to :full_address }

  describe '#full_address' do
    subject { Address.new(address: '4242 Wombatula', city: 'Wombat', state: 'WO', postal_code: '44444', country: 'US') }
    specify { expect(subject.full_address).to eq '4242 Wombatula, Wombat, WO 44444, US' }
  end
end
