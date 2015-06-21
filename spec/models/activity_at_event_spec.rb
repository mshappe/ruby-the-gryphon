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

require 'rails_helper'

RSpec.describe ActivityAtEvent, :type => :model do
  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :event_activity }
end
