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

FactoryBot.define do
  factory :poll_answer do
    poll { nil }
    active { false }
    answer { "MyText" }
    votes { 1 }
  end
end
