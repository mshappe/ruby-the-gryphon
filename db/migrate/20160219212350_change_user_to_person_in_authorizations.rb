class ChangeUserToPersonInAuthorizations < ActiveRecord::Migration
  def change
    rename_column :authorizations, :user_id, :person_id
    remove_foreign_key :authorizations, :person
    add_foreign_key :authorizations, :people
  end
end
