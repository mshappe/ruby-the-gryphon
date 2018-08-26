# frozen_string_literal: true

class CreatePollAnswers < ActiveRecord::Migration
  def change
    create_table :poll_answers do |t|
      t.references :poll, index: true, foreign_key: true
      t.boolean :active
      t.text :answer
      t.integer :votes

      t.timestamps null: false
    end
  end
end
