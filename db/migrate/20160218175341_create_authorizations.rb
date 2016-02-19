class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :authorization_type, index: true, foreign_key: true
      t.datetime :date_of
      t.text :notes

      t.timestamps null: false
    end
  end
end
