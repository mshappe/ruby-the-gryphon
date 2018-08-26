# frozen_string_literal: true

class CreatePersonHeraldicImages < ActiveRecord::Migration
  def self.up
    create_table :heraldic_images do |t|
      t.integer    :person_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :heraldic_images
  end
end
