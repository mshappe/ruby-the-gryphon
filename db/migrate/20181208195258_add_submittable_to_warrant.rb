class AddSubmittableToWarrant < ActiveRecord::Migration
  def change
    add_column :warrants, :submission_state, :string, index: true
    add_column :warrants, :supersedes_id, :integer
    add_column :warrants, :superseded_by_id, :integer
    add_foreign_key :warrants, :warrants, column: :supersedes_id, on_delete: :nullify
    add_foreign_key :warrants, :warrants, column: :superseded_by_id, on_delete: :nullify
  end
end
