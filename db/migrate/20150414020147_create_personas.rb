# frozen_string_literal: true

class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :honorific
      t.references :persona_type, index: true, foreign_key: true
      t.text :description
      t.datetime :name_registered
      t.attachment :persona_image

      t.timestamps null: false
    end
  end
end
