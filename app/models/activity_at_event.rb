# == Schema Information
#
# Table name: event_event_activity
#
#  event_id          :integer          not null
#  event_activity_id :integer          not null
#
# Indexes
#
#  index_event_event_activity_on_event_activity_id_and_event_id  (event_activity_id,event_id)
#  index_event_event_activity_on_event_id_and_event_activity_id  (event_id,event_activity_id)
#

class ActivityAtEvent < ActiveRecord::Base
  self.table_name = 'event_event_activity'
  belongs_to :event_activity
  belongs_to :event
end
