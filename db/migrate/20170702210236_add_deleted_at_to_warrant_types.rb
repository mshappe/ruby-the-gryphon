# frozen_string_literal: true

class AddDeletedAtToWarrantTypes < ActiveRecord::Migration
  def change
    add_column :warrant_types, :deleted_at, :datetime
    add_index :warrant_types, :deleted_at
  end
end
