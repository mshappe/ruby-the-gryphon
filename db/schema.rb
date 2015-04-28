# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150428212719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "addresses", ["latitude", "longitude"], name: "index_addresses_on_latitude_and_longitude", using: :btree

  create_table "adminusers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adminusers", ["confirmation_token"], name: "index_adminusers_on_confirmation_token", unique: true, using: :btree
  add_index "adminusers", ["email"], name: "index_adminusers_on_email", unique: true, using: :btree
  add_index "adminusers", ["reset_password_token"], name: "index_adminusers_on_reset_password_token", unique: true, using: :btree
  add_index "adminusers", ["unlock_token"], name: "index_adminusers_on_unlock_token", unique: true, using: :btree

  create_table "branch_heraldries", force: :cascade do |t|
    t.integer "branch_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  create_table "branch_types", force: :cascade do |t|
    t.string   "name"
    t.boolean  "full_status"
    t.boolean  "has_award"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "branches", force: :cascade do |t|
    t.string   "name"
    t.integer  "branch_type_id"
    t.integer  "region_id"
    t.string   "map_coordinates"
    t.integer  "parent_branch_id"
    t.string   "city"
    t.string   "state"
    t.string   "url"
    t.boolean  "active"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "branch_heraldry_file_name"
    t.string   "branch_heraldry_content_type"
    t.integer  "branch_heraldry_file_size"
    t.datetime "branch_heraldry_updated_at"
    t.string   "map_image_file_name"
    t.string   "map_image_content_type"
    t.integer  "map_image_file_size"
    t.datetime "map_image_updated_at"
  end

  add_index "branches", ["branch_type_id"], name: "index_branches_on_branch_type_id", using: :btree
  add_index "branches", ["name"], name: "index_branches_on_name", unique: true, using: :btree
  add_index "branches", ["region_id"], name: "index_branches_on_region_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "url"
    t.boolean  "approved"
    t.integer  "branch_id"
    t.integer  "sponsor_branch_id"
    t.string   "unlisted_host"
    t.string   "unlisted_sponsor"
    t.string   "site_name"
    t.integer  "address_id"
    t.text     "web_ad"
    t.text     "comments"
    t.text     "admin_comments"
    t.integer  "submitter_persona_id"
    t.string   "submitter_sca_name"
    t.string   "submitter_legal_name"
    t.string   "submitter_phone"
    t.string   "submitter_email"
    t.integer  "steward_persona_id"
    t.string   "steward_sca_name"
    t.string   "steward_legal_name"
    t.string   "steward_phone"
    t.string   "steward_email"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "events", ["address_id"], name: "index_events_on_address_id", using: :btree
  add_index "events", ["branch_id"], name: "index_events_on_branch_id", using: :btree
  add_index "events", ["sponsor_branch_id"], name: "index_events_on_sponsor_branch_id", using: :btree
  add_index "events", ["steward_persona_id"], name: "index_events_on_steward_persona_id", using: :btree
  add_index "events", ["submitter_persona_id"], name: "index_events_on_submitter_persona_id", using: :btree

  create_table "heradry_images", force: :cascade do |t|
    t.integer "person_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  create_table "map_images", force: :cascade do |t|
    t.integer "branch_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  create_table "people", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone"
    t.string   "phone_message"
    t.string   "gender"
    t.string   "url"
    t.datetime "date_of_birth"
    t.string   "sca_number"
    t.datetime "sca_expiration_date"
    t.boolean  "private_name"
    t.boolean  "private_address"
    t.boolean  "private_phone"
    t.boolean  "private_email"
    t.boolean  "private_persona"
    t.datetime "authorization_expiration"
    t.boolean  "active"
    t.datetime "device_registered"
    t.datetime "deceased"
    t.string   "heraldic_image_file_name"
    t.string   "heraldic_image_content_type"
    t.integer  "heraldic_image_file_size"
    t.datetime "heraldic_image_updated_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "address_id"
    t.integer  "branch_id"
  end

  add_index "people", ["address_id"], name: "index_people_on_address_id", using: :btree
  add_index "people", ["branch_id"], name: "index_people_on_branch_id", using: :btree
  add_index "people", ["user_id"], name: "index_people_on_user_id", using: :btree

  create_table "persona_images", force: :cascade do |t|
    t.integer "persona_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  create_table "persona_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "persona_types", ["name"], name: "index_persona_types_on_name", using: :btree

  create_table "personas", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "honorific"
    t.integer  "persona_type_id"
    t.text     "description"
    t.datetime "name_registered"
    t.string   "persona_image_file_name"
    t.string   "persona_image_content_type"
    t.integer  "persona_image_file_size"
    t.datetime "persona_image_updated_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "personas", ["persona_type_id"], name: "index_personas_on_persona_type_id", using: :btree
  add_index "personas", ["user_id"], name: "index_personas_on_user_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.uuid     "uuid"
    t.string   "username"
    t.text     "comment"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree
  add_index "users", ["uuid"], name: "index_users_on_uuid", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string  "foreign_key_name", null: false
    t.integer "foreign_key_id"
  end

  add_index "version_associations", ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key", using: :btree
  add_index "version_associations", ["version_id"], name: "index_version_associations_on_version_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.json     "object"
    t.json     "object_changes"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "branches", "branch_types"
  add_foreign_key "branches", "branches", column: "parent_branch_id", on_delete: :nullify
  add_foreign_key "branches", "regions"
  add_foreign_key "events", "addresses"
  add_foreign_key "events", "branches"
  add_foreign_key "events", "branches", column: "sponsor_branch_id"
  add_foreign_key "events", "personas", column: "steward_persona_id", on_delete: :nullify
  add_foreign_key "events", "personas", column: "submitter_persona_id", on_delete: :nullify
  add_foreign_key "people", "addresses"
  add_foreign_key "people", "branches"
  add_foreign_key "people", "users", on_delete: :nullify
  add_foreign_key "personas", "persona_types"
  add_foreign_key "personas", "users", on_delete: :nullify
end
