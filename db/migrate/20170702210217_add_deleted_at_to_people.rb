# frozen_string_literal: true

class AddDeletedAtToPeople < ActiveRecord::Migration
  def change
    add_column :people, :deleted_at, :datetime
    add_index :people, :deleted_at
  end
end
