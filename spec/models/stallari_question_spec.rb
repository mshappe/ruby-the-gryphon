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

require 'rails_helper'

RSpec.describe StallariQuestion, type: :model do
  it { is_expected.to validate_presence_of :question }
  it { is_expected.to belong_to :answered_persona }
end
