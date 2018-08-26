# frozen_string_literal: true

class CreateActivityAtEvents < ActiveRecord::Migration
  def change
    create_join_table :event, :event_activity do |t|
      t.index %i[event_id event_activity_id]
      t.index %i[event_activity_id event_id]
    end
  end
end
