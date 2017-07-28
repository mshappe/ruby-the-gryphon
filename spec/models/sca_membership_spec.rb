# == Schema Information
#
# Table name: sca_memberships
#
#  sca_number   :string           primary key
#  sca_exp_date :datetime
#
# Indexes
#
#  index_sca_memberships_on_sca_number  (sca_number)
#

require 'rails_helper'

RSpec.describe ScaMembership, type: :model do
  it { is_expected.to validate_presence_of :sca_number }
  it { is_expected.to validate_uniqueness_of :sca_number }
  it { is_expected.to validate_presence_of :sca_exp_date }
end
