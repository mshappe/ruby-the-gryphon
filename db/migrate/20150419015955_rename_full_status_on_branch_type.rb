# frozen_string_literal: true

class RenameFullStatusOnBranchType < ActiveRecord::Migration
  def change
    rename_column :branch_types, :fulL_status, :full_status
  end
end
