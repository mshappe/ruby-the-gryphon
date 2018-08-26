# frozen_string_literal: true

class FixAuthorizationType < ActiveRecord::Migration
  def change
    remove_column :authorization_types, :group, :integer
    add_reference :authorization_types, :martial_activity_type, index: true
  end
end
