# frozen_string_literal: true

class CreateBranchTypes < ActiveRecord::Migration
  def change
    create_table :branch_types do |t|
      t.string :name
      t.boolean :fulL_status
      t.boolean :has_award

      t.timestamps null: false
    end
  end
end
