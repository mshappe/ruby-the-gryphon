class CreateWarrantTypes < ActiveRecord::Migration
  def change
    create_table :warrant_types do |t|
      t.string :name
      t.string :email
      t.attachment :warrant_badge
      t.boolean :missive
      t.integer :stallari_order
      t.text :job_description
      t.integer :superior_warrant_id
      t.boolean :background_check_required
      t.boolean :northwatch_display
      t.string :icon_file_name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
