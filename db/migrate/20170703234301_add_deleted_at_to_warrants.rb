# frozen_string_literal: true

class AddDeletedAtToWarrants < ActiveRecord::Migration
  def change
    add_column :warrants, :deleted_at, :datetime
    add_index :warrants, :deleted_at
  end
end
