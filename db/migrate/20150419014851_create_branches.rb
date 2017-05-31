class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.references :branch_type, index: true, foreign_key: true
      t.integer :region_id
      t.string :branch_heraldry
      t.string :map_image
      t.string :map_coordinates
      t.integer :parent_branch_id
      t.string :city
      t.string :state
      t.string :url
      t.boolean :active

      t.timestamps null: false
    end
    add_index :branches, :name, unique: true
    add_foreign_key "branches", "branches", column: :parent_branch_id, primary_key: :id, on_delete: :nullify
  end
end
