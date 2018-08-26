# frozen_string_literal: true

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

require 'rails_helper'

RSpec.describe BranchType, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end
