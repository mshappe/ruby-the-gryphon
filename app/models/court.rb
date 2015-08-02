# == Schema Information
#
# Table name: courts
#
#  id                  :integer          not null, primary key
#  court_order         :integer          default(1)
#  court_date          :datetime
#  event_id            :integer
#  reign_id            :integer
#  regent_persona_id   :integer
#  reporter_persona_id :integer
#  herald_persona_id   :integer
#  note                :text
#  planning_notes      :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_courts_on_event_id  (event_id)
#  index_courts_on_reign_id  (reign_id)
#

class Court < ActiveRecord::Base
  has_paper_trail

  belongs_to :event
  belongs_to :reign
  belongs_to :regent_persona, class_name: 'Persona', foreign_key: 'regent_persona_id'
  belongs_to :reporter_persona, class_name: 'Persona', foreign_key: 'reporter_persona_id'
  belongs_to :herald_persona, class_name: 'Persona', foreign_key: 'herald_persona_id'
end
