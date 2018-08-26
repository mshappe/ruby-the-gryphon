# frozen_string_literal: true

class CreateStallariQuestions < ActiveRecord::Migration
  def change
    create_table :stallari_questions do |t|
      t.text :question
      t.text :answer
      t.string :reply_email
      t.datetime :answered_date
      t.integer :answered_persona_id, index: true # Would be great to have an FK constraint but source data is not consistent
      t.boolean :active

      t.timestamps null: false
    end
  end
end
