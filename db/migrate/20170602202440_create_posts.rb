class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :post_type_id
      t.references :persona, index: true
      t.references :warrant_type, index: true
      t.string :title, limit: 200
      t.text :body
      t.string :url, limit: 200
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :approved

      t.timestamps null: false
    end
  end
end
