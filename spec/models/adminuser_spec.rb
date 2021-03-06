# frozen_string_literal: true

# == Schema Information
#
# Table name: adminusers
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_adminusers_on_confirmation_token    (confirmation_token) UNIQUE
#  index_adminusers_on_email                 (email) UNIQUE
#  index_adminusers_on_reset_password_token  (reset_password_token) UNIQUE
#  index_adminusers_on_unlock_token          (unlock_token) UNIQUE
#

require 'rails_helper'

RSpec.describe Adminuser, type: :model do
  it { is_expected.to validate_presence_of :email }
end
