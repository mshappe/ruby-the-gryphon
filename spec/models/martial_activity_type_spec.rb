# frozen_string_literal: true

# == Schema Information
#
# Table name: martial_activity_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_martial_activity_types_on_name  (name)
#

require 'rails_helper'

RSpec.describe MartialActivityType, type: :model do
  it { is_expected.to have_many :authorization_types }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end
