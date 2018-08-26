# frozen_string_literal: true

class RemoveMisspelledHeradryTable < ActiveRecord::Migration
  def change
    drop_table :heradry_images if table_exists? :heradry_images
  end
end
