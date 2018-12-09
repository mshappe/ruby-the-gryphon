class ConvertOldApprovedColumnOnWarrant < ActiveRecord::Migration
  def up
    # Don't do this if the old approved column no longer exists
    if Warrant.column_names.include? 'approved'
      Warrant.where.not(approved: nil).update_all(submission_state: 'approved')
      rename_column :warrants, :approved, :approved_date
    end
  end
end
