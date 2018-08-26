# frozen_string_literal: true

class CreateAwardRecipientRecommendations < ActiveRecord::Migration
  def change
    create_table :award_recipient_recommendations do |t|
      t.references :award_recipient, index: true, foreign_key: true
      # The auto-generated index name is too long!
      t.references :award_recommendation, index: true, foreign_key: true, index: { name: :award_rec_on_award_rec_id }

      t.timestamps null: false
    end
  end
end
