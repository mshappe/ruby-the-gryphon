class CreateTreaties < ActiveRecord::Migration
  def change
    create_table :treaties do |t|
      t.references :persona, index: true
      t.references :treaty_type, polymorphic: true, index: true
      t.references :reign, index: true
      t.integer :foreign_branch_id, index: true
      t.text :user_comment
      t.text :royal_comment
      t.text :foreign_comment
      t.datetime :royal_approved
      t.datetime :foreign_approved
      t.string :royal_status, limit: 1
      t.string :foreign_status, limit: 1

      t.timestamps null: false
    end
  end
end
