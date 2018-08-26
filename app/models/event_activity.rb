# frozen_string_literal: true

# == Schema Information
#
# Table name: drop_down_items
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  type        :string
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EventActivity < DropDownItem
  has_and_belongs_to_many :events, join_table: 'event_event_activity'

  def activity_label
    name.gsub(' ', '&nbsp;').html_safe
  end
end
