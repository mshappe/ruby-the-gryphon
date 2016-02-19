# == Schema Information
#
# Table name: authorization_types
#
#  id         :integer          not null, primary key
#  name       :string
#  group      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe AuthorizationType, :type => :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to validate_presence_of :group }
end
