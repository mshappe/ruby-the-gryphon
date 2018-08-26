# frozen_string_literal: true

# == Schema Information
#
# Table name: event_attendees
#
#  id                      :integer          not null, primary key
#  event_id                :integer
#  persona_id              :integer
#  warrant_type_id         :integer
#  award_recommendation_id :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_event_attendees_on_award_recommendation_id  (award_recommendation_id)
#  index_event_attendees_on_event_id                 (event_id)
#  index_event_attendees_on_persona_id               (persona_id)
#  index_event_attendees_on_warrant_type_id          (warrant_type_id)
#

class EventAttendee < ActiveRecord::Base
  belongs_to :event
  belongs_to :persona
  belongs_to :warrant_type
  belongs_to :award_recommendation
end
