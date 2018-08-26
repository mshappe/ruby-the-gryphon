# frozen_string_literal: true

class CreateAwardRecipientAwardRecipientThumbnailsAndAwardRecipientImages < ActiveRecord::Migration
  def self.up
    create_table :award_recipient_thumbnails do |t|
      t.integer    :award_recipient_id
      t.string     :style
      t.binary     :file_contents
    end
    create_table :award_recipient_images do |t|
      t.integer    :award_recipient_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :award_recipient_thumbnails
    drop_table :award_recipient_images
  end
end
