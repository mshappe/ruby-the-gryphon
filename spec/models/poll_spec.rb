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
  pending "add some examples to (or delete) #{__FILE__}"
end
