class CreateAuthorizationTypes < ActiveRecord::Migration
  def change
    create_table :authorization_types do |t|
      t.string :name
      t.integer :group # arbitrary to make sure entries sort together

      t.timestamps null: false
    end
  end
end
