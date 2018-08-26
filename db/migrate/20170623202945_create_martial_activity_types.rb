# frozen_string_literal: true

class CreateMartialActivityTypes < ActiveRecord::Migration
  def change
    create_table :martial_activity_types do |t|
      t.string :name, index: true, unique: true

      t.timestamps null: false
    end
  end
end
