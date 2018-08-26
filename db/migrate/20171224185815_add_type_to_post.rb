# frozen_string_literal: true

class AddTypeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :type, :string, default: 'Post'
    add_index :posts, :type
  end
end
