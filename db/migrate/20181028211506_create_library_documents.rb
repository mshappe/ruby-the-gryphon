class CreateLibraryDocuments < ActiveRecord::Migration
  def change
    create_table :library_documents do |t|
      t.string :title
      t.integer :order
      t.references :library_section, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.has_attached_file :attachment

      t.timestamps null: false
    end
  end
end
