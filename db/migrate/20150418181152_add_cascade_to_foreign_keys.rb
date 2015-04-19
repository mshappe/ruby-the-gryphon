class AddCascadeToForeignKeys < ActiveRecord::Migration
  def change
    remove_foreign_key 'people', 'users'
    add_foreign_key 'people', 'users', on_delete: :nullify # People records can outlive user records!
    remove_foreign_key "personas", "users"
    add_foreign_key "personas", "users", on_delete: :nullify # Persona records can outlive user records!
  end
end
