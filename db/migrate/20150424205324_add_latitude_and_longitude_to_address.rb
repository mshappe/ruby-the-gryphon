# frozen_string_literal: true

class AddLatitudeAndLongitudeToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :latitude, :float
    add_column :addresses, :longitude, :float
  end
end
