# frozen_string_literal: true

class RemoveApprovedFromEvent < ActiveRecord::Migration
  class Event < ActiveRecord::Base
  end

  def up
    if Event.column_names.include? 'approved'
      Event.all.find_each do |e|
        ap '-'
        e.update_attribute :submission_state, (e[:approved] == true ? 'approved' : 'queued')
      end
    end

    remove_column :events, :approved
  end

  def down
    add_column :events, :approved, :boolean, default: false

    Event.all.find_each do |e|
      e.update_attribute :approved, e[:submission_state] == 'approved'
    end
  end
end
