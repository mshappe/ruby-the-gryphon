# frozen_string_literal: true

class CreatePersonHeradryImages < ActiveRecord::Migration
  def self.up
    create_table :heradry_images do |t|
      t.integer    :person_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :heradry_images
  end
end
