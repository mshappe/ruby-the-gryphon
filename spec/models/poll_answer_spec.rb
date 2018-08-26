# frozen_string_literal: true

# == Schema Information
#
# Table name: poll_answers
#
#  id         :integer          not null, primary key
#  poll_id    :integer
#  active     :boolean
#  answer     :text
#  votes      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_poll_answers_on_poll_id  (poll_id)
#

require 'rails_helper'

RSpec.describe PollAnswer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
