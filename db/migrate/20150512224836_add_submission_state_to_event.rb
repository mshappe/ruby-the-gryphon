class AddSubmissionStateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :submission_state, :string
    add_index :events, :submission_state
  end
end
