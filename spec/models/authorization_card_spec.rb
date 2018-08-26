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

require 'rails_helper'

RSpec.describe AuthorizationCard, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :expiration_date }
end
