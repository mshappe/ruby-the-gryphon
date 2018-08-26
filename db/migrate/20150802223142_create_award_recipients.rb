# frozen_string_literal: true

class CreateAwardRecipients < ActiveRecord::Migration
  def change
    create_table :award_recipients do |t|
      t.references :award, index: true, foreign_key: true
      t.references :persona, index: true, foreign_key: true
      t.references :court, index: true, foreign_key: true
      t.integer :status_id
      t.datetime :received
      t.datetime :revoked
      t.attachment :award_recipient_thumbnail
      t.attachment :award_recipient_image
      t.text :award_content
      t.text :creation_notes
      t.text :reason
      t.text :note

      t.timestamps null: false
    end
  end
end
