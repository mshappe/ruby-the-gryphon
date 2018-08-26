# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.string :url
      t.boolean :approved
      t.references :branch, index: true, foreign_key: true
      t.integer :sponsor_branch_id
      t.string :unlisted_host
      t.string :unlisted_sponsor
      t.string :site_name
      t.references :address, index: true, foreign_key: true
      t.text :web_ad
      t.text :comments
      t.text :admin_comments
      t.integer :submitter_persona_id
      t.string :submitter_sca_name
      t.string :submitter_legal_name
      t.string :submitter_phone
      t.string :submitter_email
      t.integer :steward_persona_id
      t.string :steward_sca_name
      t.string :steward_legal_name
      t.string :steward_phone
      t.string :steward_email

      t.timestamps null: false
    end

    add_index :events, :sponsor_branch_id
    add_foreign_key :events, :branches, column: :sponsor_branch_id
    add_index :events, :submitter_persona_id
    add_foreign_key :events, :personas, column: :submitter_persona_id, on_delete: :nullify
    add_index :events, :steward_persona_id
    add_foreign_key :events, :personas, column: :steward_persona_id, on_delete: :nullify
  end
end
