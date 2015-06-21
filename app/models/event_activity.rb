class EventActivity < DropDownItem
  has_and_belongs_to_many :events, join_table: 'event_event_activity'

  def activity_label
    name.gsub(' ', '&nbsp;').html_safe
  end

end
