# frozen_string_literal: true

class CreateBranchBranchHeraldries < ActiveRecord::Migration
  def self.up
    create_table :branch_heraldries do |t|
      t.integer    :branch_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :branch_heraldries
  end
end
