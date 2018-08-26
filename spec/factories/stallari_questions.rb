# frozen_string_literal: true

# == Schema Information
#
# Table name: stallari_questions
#
#  id                  :integer          not null, primary key
#  question            :text
#  answer              :text
#  reply_email         :string
#  answered_date       :datetime
#  answered_persona_id :integer
#  active              :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_stallari_questions_on_answered_persona_id  (answered_persona_id)
#

FactoryBot.define do
  factory :stallari_question do
    question { 'MyText' }
    answer { 'MyText' }
    reply_email { 'MyString' }
    answered_date { '2017-06-02 13:59:50' }
    answered_persona_id { 1 }
    warrant_type { nil }
    active { false }
  end
end
