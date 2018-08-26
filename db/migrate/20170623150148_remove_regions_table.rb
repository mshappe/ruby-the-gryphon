# frozen_string_literal: true

class RemoveRegionsTable < ActiveRecord::Migration
  def change
    remove_foreign_key :branches, :regions if foreign_keys(:branches).include?(:region_id)
    drop_table :regions if table_exists? :regions
  end
end
