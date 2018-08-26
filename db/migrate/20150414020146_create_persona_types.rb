# frozen_string_literal: true

class CreatePersonaTypes < ActiveRecord::Migration
  def change
    create_table :persona_types do |t|
      t.string :name, index: true

      t.timestamps null: false
    end
  end
end
