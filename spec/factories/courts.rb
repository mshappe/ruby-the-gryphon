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

FactoryGirl.define do
  factory :court do
    court_order 1
    court_date "2015-07-19 17:51:54"
    association :event
    reign nil
    regent_persona_id 1
    reporter_persona_id 1
    herald_persona_id 1
    note "MyText"
    planning_notes "MyText"
  end

end
