class CreateDropDownItems < ActiveRecord::Migration
  def change
    create_table :drop_down_items do |t|
      t.string :name
      t.text :description
      t.string :type
      t.boolean :active

      t.timestamps null: false
    end
  end
end
