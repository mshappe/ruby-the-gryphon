class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.references :persona, index: true, foreign_key: true
      t.references :reign, index: true, foreign_key: true
      t.string :name, limit: 100

      t.timestamps null: false
    end
  end
end
