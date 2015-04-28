class AddLatLongIndexToAddress < ActiveRecord::Migration
  def change
    add_index :addresses, [:latitude, :longitude]
  end
end
