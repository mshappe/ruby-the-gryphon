# frozen_string_literal: true

class AddAddressIdToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :address, index: true, foreign_key: true
  end
end
