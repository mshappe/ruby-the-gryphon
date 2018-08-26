# frozen_string_literal: true

class AddBranchToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :branch, index: true, foreign_key: true
  end
end
