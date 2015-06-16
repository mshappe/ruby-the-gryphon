# == Schema Information
#
# Table name: drop_down_items
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  type        :string
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe DropDownItem, :type => :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end

RSpec.describe EventActivity, type: :model do
  it { is_expected.to have_and_belong_to_many :events }
end
