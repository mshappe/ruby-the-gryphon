class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.text :question
      t.boolean :active

      t.timestamps null: false
    end
  end
end
