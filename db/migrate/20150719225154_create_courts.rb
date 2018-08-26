# frozen_string_literal: true

class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.integer :court_order, default: 1
      t.datetime :court_date
      t.references :event, index: true, foreign_key: true
      t.references :reign, index: true, foreign_key: true
      t.integer :regent_persona_id
      t.integer :reporter_persona_id
      t.integer :herald_persona_id
      t.text :note
      t.text :planning_notes

      t.timestamps null: false
    end
  end
end
