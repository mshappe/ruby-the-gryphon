# frozen_string_literal: true

class AddLatLongIndexToAddress < ActiveRecord::Migration
  def change
    add_index :addresses, %i[latitude longitude]
  end
end
