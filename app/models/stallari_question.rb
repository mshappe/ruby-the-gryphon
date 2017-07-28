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

class StallariQuestion < ActiveRecord::Base
  belongs_to :answered_persona, class_name: 'Persona'

  validates :question, presence: true
end
