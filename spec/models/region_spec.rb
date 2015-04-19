# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Region, :type => :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end
