# frozen_string_literal: true

class AddSupersedesAndSupersededByToEvent < ActiveRecord::Migration
  def change
    add_column :events, :supersedes_id, :integer
    add_column :events, :superseded_by_id, :integer
    add_foreign_key :events, :events, column: :supersedes_id, on_delete: :nullify
    add_foreign_key :events, :events, column: :superseded_by_id, on_delete: :nullify
  end
end
