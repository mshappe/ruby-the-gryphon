# frozen_string_literal: true

class AddUuidToUser < ActiveRecord::Migration
  def change
    add_column :users, :uuid, :uuid
    add_index :users, :uuid, unique: true
    add_index :users, :confirmation_token, unique: true
    add_index :users, :unlock_token, unique: true
  end
end
