# frozen_string_literal: true

# == Schema Information
#
# Table name: authorization_types
#
#  id                       :integer          not null, primary key
#  name                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  martial_activity_type_id :integer
#
# Indexes
#
#  index_authorization_types_on_martial_activity_type_id  (martial_activity_type_id)
#

require 'rails_helper'

RSpec.describe AuthorizationType, type: :model do
  it { is_expected.to belong_to :martial_activity_type }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:martial_activity_type_id) }
end
