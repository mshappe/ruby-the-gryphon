# == Schema Information
#
# Table name: award_scribes
#
#  id                   :integer          not null, primary key
#  award_recipient_id   :integer
#  person_id            :integer
#  award_scribe_type_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_award_scribes_on_award_recipient_id    (award_recipient_id)
#  index_award_scribes_on_award_scribe_type_id  (award_scribe_type_id)
#  index_award_scribes_on_person_id             (person_id)
#

class AwardScribe < ActiveRecord::Base
  belongs_to :award_recipient
  belongs_to :person
  belongs_to :award_scribe_type, class_name: 'AwardScribeType'
end
