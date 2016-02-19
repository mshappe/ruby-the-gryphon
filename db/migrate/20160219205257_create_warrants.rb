class CreateWarrants < ActiveRecord::Migration
  def change
    create_table :warrants do |t|
      t.references :person, index: true, foreign_key: true
      t.references :warrant_type, index: true, foreign_key: true
      t.datetime :tenure_start
      t.datetime :tenure_end
      t.references :branch, index: true, foreign_key: true
      t.datetime :approved
      t.text :introduction
      t.text :comments

      t.timestamps null: false
    end
  end
end
