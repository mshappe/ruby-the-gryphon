# frozen_string_literal: true

# == Schema Information
#
# Table name: persona_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_persona_types_on_name  (name)
#

require 'rails_helper'

RSpec.describe PersonaType, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to have_many :personas }
end
