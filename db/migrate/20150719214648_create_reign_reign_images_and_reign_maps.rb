# frozen_string_literal: true

class CreateReignReignImagesAndReignMaps < ActiveRecord::Migration
  def self.up
    create_table :reign_images do |t|
      t.integer    :reign_id
      t.string     :style
      t.binary     :file_contents
    end
    create_table :reign_maps do |t|
      t.integer    :reign_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :reign_images
    drop_table :reign_maps
  end
end
