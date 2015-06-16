class ActivityAtEvent < ActiveRecord::Base
  self.table_name = 'event_event_activity'
  belongs_to :event_activity
  belongs_to :event
end
