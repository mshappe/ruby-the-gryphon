# frozen_string_literal: true

class CreateAwardRecommendations < ActiveRecord::Migration
  def change
    create_table :award_recommendations do |t|
      t.references :award, index: true, foreign_key: true
      t.references :persona, index: true, foreign_key: true
      t.string :persona_name
      t.string :legal_name
      t.references :branch, index: true, foreign_key: true
      t.string :gender
      t.text :persona_description
      t.boolean :is_youth
      t.integer :sca_term
      t.text :reason
      t.string :status
      t.integer :planned_court_id
      t.integer :submitted_by_user_id

      t.timestamps null: false
    end
  end
end
