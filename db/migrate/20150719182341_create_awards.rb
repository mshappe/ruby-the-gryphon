class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :name
      t.text :description
      t.integer :precedence
      t.attachment :award_badge
      t.references :award_type
      t.references :branch
      t.boolean :active

      t.timestamps null: false
    end

    add_index :awards, :award_type_id
    add_index :awards, :branch_id
  end
end
