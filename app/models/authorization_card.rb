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

class AuthorizationCard < ActiveRecord::Base
  belongs_to :user
  validates :expiration_date, presence: true
end
