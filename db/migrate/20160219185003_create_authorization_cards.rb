# frozen_string_literal: true

class CreateAuthorizationCards < ActiveRecord::Migration
  def change
    create_table :authorization_cards do |t|
      t.references :user, index: true, foreign_key: true
      t.datetime :expiration_date

      t.timestamps null: false
    end
  end
end
