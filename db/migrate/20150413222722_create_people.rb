class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :phone
      t.string :phone_message
      t.string :gender
      t.string :url
      t.datetime :date_of_birth
      t.integer :sca_number
      t.datetime :sca_expiration_date
      t.boolean :private_name
      t.boolean :private_address
      t.boolean :private_phone
      t.boolean :private_email
      t.boolean :private_persona
      t.datetime :authorization_expiration
      t.boolean :active
      t.datetime :device_registered
      t.datetime :deceased
      t.attachment :heraldic_image

      t.timestamps null: false
    end
  end
end
