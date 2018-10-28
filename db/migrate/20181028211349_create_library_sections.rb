class CreateLibrarySections < ActiveRecord::Migration
  def change
    create_table :library_sections do |t|
      t.string :name
      t.integer :order

      t.timestamps null: false
    end
  end
end
