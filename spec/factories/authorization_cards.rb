# frozen_string_literal: true

# == Schema Information
#
# Table name: authorization_cards
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  expiration_date :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_authorization_cards_on_user_id  (user_id)
#

FactoryBot.define do
  factory :authorization_card do
    user { nil }
    expiration_date { '2016-02-19 12:50:03' }
  end
end
