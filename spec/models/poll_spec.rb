# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  question   :text
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Poll, :type => :model do
  it { is_expected.to have_many :poll_answers }
end
