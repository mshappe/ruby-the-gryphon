# frozen_string_literal: true

class AddBodyFieldsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :body_fields, :jsonb
  end
end
