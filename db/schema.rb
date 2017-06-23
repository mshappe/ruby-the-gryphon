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

ActiveRecord::Schema.define(version: 20170623203220) do

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

  create_table "authorization_cards", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "expiration_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "authorization_cards", ["user_id"], name: "index_authorization_cards_on_user_id", using: :btree

  create_table "authorization_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "martial_activity_type_id"
  end

  add_index "authorization_types", ["martial_activity_type_id"], name: "index_authorization_types_on_martial_activity_type_id", using: :btree

  create_table "authorizations", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "authorization_type_id"
    t.datetime "date_of"
    t.text     "notes"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "authorizations", ["authorization_type_id"], name: "index_authorizations_on_authorization_type_id", using: :btree
  add_index "authorizations", ["person_id"], name: "index_authorizations_on_person_id", using: :btree

  create_table "award_badges", force: :cascade do |t|
    t.integer "award_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  add_index "award_badges", ["award_id"], name: "index_award_badges_on_award_id", using: :btree

  create_table "award_recipient_images", force: :cascade do |t|
    t.integer "award_recipient_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  add_index "award_recipient_images", ["award_recipient_id"], name: "index_award_recipient_images_on_award_recipient_id", using: :btree

  create_table "award_recipient_recommendations", force: :cascade do |t|
    t.integer  "award_recipient_id"
    t.integer  "award_recommendation_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "award_recipient_recommendations", ["award_recipient_id"], name: "index_award_recipient_recommendations_on_award_recipient_id", using: :btree
  add_index "award_recipient_recommendations", ["award_recommendation_id"], name: "award_rec_on_award_rec_id", using: :btree

  create_table "award_recipient_thumbnails", force: :cascade do |t|
    t.integer "award_recipient_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  add_index "award_recipient_thumbnails", ["award_recipient_id"], name: "index_award_recipient_thumbnails_on_award_recipient_id", using: :btree

  create_table "award_recipients", force: :cascade do |t|
    t.integer  "award_id"
    t.integer  "persona_id"
    t.integer  "court_id"
    t.integer  "status_id"
    t.datetime "received"
    t.datetime "revoked"
    t.string   "award_recipient_thumbnail_file_name"
    t.string   "award_recipient_thumbnail_content_type"
    t.integer  "award_recipient_thumbnail_file_size"
    t.datetime "award_recipient_thumbnail_updated_at"
    t.string   "award_recipient_image_file_name"
    t.string   "award_recipient_image_content_type"
    t.integer  "award_recipient_image_file_size"
    t.datetime "award_recipient_image_updated_at"
    t.text     "award_content"
    t.text     "creation_notes"
    t.text     "reason"
    t.text     "note"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "award_recipients", ["award_id"], name: "index_award_recipients_on_award_id", using: :btree
  add_index "award_recipients", ["court_id"], name: "index_award_recipients_on_court_id", using: :btree
  add_index "award_recipients", ["persona_id"], name: "index_award_recipients_on_persona_id", using: :btree

  create_table "award_recommendations", force: :cascade do |t|
    t.integer  "award_id"
    t.integer  "persona_id"
    t.string   "persona_name"
    t.string   "legal_name"
    t.integer  "branch_id"
    t.string   "gender"
    t.text     "persona_description"
    t.boolean  "is_youth"
    t.integer  "sca_term"
    t.text     "reason"
    t.string   "status"
    t.integer  "planned_court_id"
    t.integer  "submitted_by_user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "award_recommendations", ["award_id"], name: "index_award_recommendations_on_award_id", using: :btree
  add_index "award_recommendations", ["branch_id"], name: "index_award_recommendations_on_branch_id", using: :btree
  add_index "award_recommendations", ["persona_id"], name: "index_award_recommendations_on_persona_id", using: :btree
  add_index "award_recommendations", ["planned_court_id"], name: "index_award_recommendations_on_planned_court_id", using: :btree
  add_index "award_recommendations", ["submitted_by_user_id"], name: "index_award_recommendations_on_submitted_by_user_id", using: :btree

  create_table "award_scribes", force: :cascade do |t|
    t.integer  "award_recipient_id"
    t.integer  "person_id"
    t.integer  "award_scribe_type_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "award_scribes", ["award_recipient_id"], name: "index_award_scribes_on_award_recipient_id", using: :btree
  add_index "award_scribes", ["award_scribe_type_id"], name: "index_award_scribes_on_award_scribe_type_id", using: :btree
  add_index "award_scribes", ["person_id"], name: "index_award_scribes_on_person_id", using: :btree

  create_table "awards", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "precedence"
    t.string   "award_badge_file_name"
    t.string   "award_badge_content_type"
    t.integer  "award_badge_file_size"
    t.datetime "award_badge_updated_at"
    t.integer  "award_type_id"
    t.integer  "branch_id"
    t.boolean  "active"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "awards", ["award_type_id"], name: "index_awards_on_award_type_id", using: :btree
  add_index "awards", ["branch_id"], name: "index_awards_on_branch_id", using: :btree

  create_table "branch_heraldries", force: :cascade do |t|
    t.integer "branch_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  add_index "branch_heraldries", ["branch_id"], name: "index_branch_heraldries_on_branch_id", using: :btree

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
  add_index "branches", ["parent_branch_id"], name: "index_branches_on_parent_branch_id", using: :btree

  create_table "champions", force: :cascade do |t|
    t.integer  "persona_id"
    t.integer  "reign_id"
    t.string   "name",       limit: 100
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "champions", ["persona_id"], name: "index_champions_on_persona_id", using: :btree
  add_index "champions", ["reign_id"], name: "index_champions_on_reign_id", using: :btree

  create_table "courts", force: :cascade do |t|
    t.integer  "court_order",         default: 1
    t.datetime "court_date"
    t.integer  "event_id"
    t.integer  "reign_id"
    t.integer  "regent_persona_id"
    t.integer  "reporter_persona_id"
    t.integer  "herald_persona_id"
    t.text     "note"
    t.text     "planning_notes"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "courts", ["event_id"], name: "index_courts_on_event_id", using: :btree
  add_index "courts", ["herald_persona_id"], name: "index_courts_on_herald_persona_id", using: :btree
  add_index "courts", ["regent_persona_id"], name: "index_courts_on_regent_persona_id", using: :btree
  add_index "courts", ["reign_id"], name: "index_courts_on_reign_id", using: :btree
  add_index "courts", ["reporter_persona_id"], name: "index_courts_on_reporter_persona_id", using: :btree

  create_table "drop_down_items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "type"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "event_attendees", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "persona_id"
    t.integer  "warrant_type_id"
    t.integer  "award_recommendation_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "event_attendees", ["award_recommendation_id"], name: "index_event_attendees_on_award_recommendation_id", using: :btree
  add_index "event_attendees", ["event_id"], name: "index_event_attendees_on_event_id", using: :btree
  add_index "event_attendees", ["persona_id"], name: "index_event_attendees_on_persona_id", using: :btree
  add_index "event_attendees", ["warrant_type_id"], name: "index_event_attendees_on_warrant_type_id", using: :btree

  create_table "event_event_activity", id: false, force: :cascade do |t|
    t.integer "event_id",          null: false
    t.integer "event_activity_id", null: false
  end

  add_index "event_event_activity", ["event_activity_id", "event_id"], name: "index_event_event_activity_on_event_activity_id_and_event_id", using: :btree
  add_index "event_event_activity", ["event_id", "event_activity_id"], name: "index_event_event_activity_on_event_id_and_event_activity_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "url"
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
    t.string   "submission_state"
    t.integer  "supersedes_id"
    t.integer  "superseded_by_id"
  end

  add_index "events", ["address_id"], name: "index_events_on_address_id", using: :btree
  add_index "events", ["branch_id"], name: "index_events_on_branch_id", using: :btree
  add_index "events", ["sponsor_branch_id"], name: "index_events_on_sponsor_branch_id", using: :btree
  add_index "events", ["steward_persona_id"], name: "index_events_on_steward_persona_id", using: :btree
  add_index "events", ["submission_state"], name: "index_events_on_submission_state", using: :btree
  add_index "events", ["submitter_persona_id"], name: "index_events_on_submitter_persona_id", using: :btree

  create_table "heraldic_images", force: :cascade do |t|
    t.integer "person_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  add_index "heraldic_images", ["person_id"], name: "index_heraldic_images_on_person_id", using: :btree

  create_table "map_images", force: :cascade do |t|
    t.integer "branch_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  add_index "map_images", ["branch_id"], name: "index_map_images_on_branch_id", using: :btree

  create_table "martial_activity_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "martial_activity_types", ["name"], name: "index_martial_activity_types_on_name", using: :btree

  create_table "peer_candidate_comments", force: :cascade do |t|
    t.integer  "peer_candidate_id"
    t.integer  "person_id"
    t.datetime "timestamp",         null: false
    t.text     "comments"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "peer_candidate_comments", ["peer_candidate_id"], name: "index_peer_candidate_comments_on_peer_candidate_id", using: :btree
  add_index "peer_candidate_comments", ["person_id"], name: "index_peer_candidate_comments_on_person_id", using: :btree

  create_table "peer_candidates", force: :cascade do |t|
    t.integer  "award_id"
    t.integer  "persona_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "peer_candidates", ["active"], name: "index_peer_candidates_on_active", using: :btree
  add_index "peer_candidates", ["award_id"], name: "index_peer_candidates_on_award_id", using: :btree
  add_index "peer_candidates", ["persona_id"], name: "index_peer_candidates_on_persona_id", using: :btree

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

  add_index "persona_images", ["persona_id"], name: "index_persona_images_on_persona_id", using: :btree

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

  create_table "poll_answers", force: :cascade do |t|
    t.integer  "poll_id"
    t.boolean  "active"
    t.text     "answer"
    t.integer  "votes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "poll_answers", ["poll_id"], name: "index_poll_answers_on_poll_id", using: :btree

  create_table "polls", force: :cascade do |t|
    t.text     "question"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "post_type_id"
    t.integer  "persona_id"
    t.integer  "warrant_type_id"
    t.string   "title",           limit: 200
    t.text     "body"
    t.string   "url",             limit: 200
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "approved"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "posts", ["persona_id"], name: "index_posts_on_persona_id", using: :btree
  add_index "posts", ["warrant_type_id"], name: "index_posts_on_warrant_type_id", using: :btree

  create_table "reign_images", force: :cascade do |t|
    t.integer "reign_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  add_index "reign_images", ["reign_id"], name: "index_reign_images_on_reign_id", using: :btree

  create_table "reign_maps", force: :cascade do |t|
    t.integer "reign_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  add_index "reign_maps", ["reign_id"], name: "index_reign_maps_on_reign_id", using: :btree

  create_table "reigns", force: :cascade do |t|
    t.string   "name"
    t.integer  "combatant_persona_id"
    t.integer  "consort_persona_id"
    t.string   "reign_image_file_name"
    t.string   "reign_image_content_type"
    t.integer  "reign_image_file_size"
    t.datetime "reign_image_updated_at"
    t.integer  "crown_event_id"
    t.integer  "coronation_event_id"
    t.string   "url"
    t.integer  "runner_up_persona_id"
    t.integer  "runner_up_consort_persona_id"
    t.string   "reign_map_file_name"
    t.string   "reign_map_content_type"
    t.integer  "reign_map_file_size"
    t.datetime "reign_map_updated_at"
    t.integer  "reign_map_description"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "reigns", ["combatant_persona_id"], name: "index_reigns_on_combatant_persona_id", using: :btree
  add_index "reigns", ["consort_persona_id"], name: "index_reigns_on_consort_persona_id", using: :btree
  add_index "reigns", ["coronation_event_id"], name: "index_reigns_on_coronation_event_id", using: :btree
  add_index "reigns", ["crown_event_id"], name: "index_reigns_on_crown_event_id", using: :btree
  add_index "reigns", ["runner_up_consort_persona_id"], name: "index_reigns_on_runner_up_consort_persona_id", using: :btree
  add_index "reigns", ["runner_up_persona_id"], name: "index_reigns_on_runner_up_persona_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sca_memberships", id: false, force: :cascade do |t|
    t.string   "sca_number"
    t.datetime "sca_exp_date"
  end

  add_index "sca_memberships", ["sca_number"], name: "index_sca_memberships_on_sca_number", using: :btree

  create_table "stallari_questions", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.string   "reply_email"
    t.datetime "answered_date"
    t.integer  "answered_persona_id"
    t.boolean  "active"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "stallari_questions", ["answered_persona_id"], name: "index_stallari_questions_on_answered_persona_id", using: :btree

  create_table "treaties", force: :cascade do |t|
    t.integer  "persona_id"
    t.integer  "treaty_type_id"
    t.string   "treaty_type_type"
    t.integer  "reign_id"
    t.integer  "foreign_branch_id"
    t.text     "user_comment"
    t.text     "royal_comment"
    t.text     "foreign_comment"
    t.datetime "royal_approved"
    t.datetime "foreign_approved"
    t.string   "royal_status",      limit: 1
    t.string   "foreign_status",    limit: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "treaties", ["foreign_branch_id"], name: "index_treaties_on_foreign_branch_id", using: :btree
  add_index "treaties", ["persona_id"], name: "index_treaties_on_persona_id", using: :btree
  add_index "treaties", ["reign_id"], name: "index_treaties_on_reign_id", using: :btree
  add_index "treaties", ["treaty_type_type", "treaty_type_id"], name: "index_treaties_on_treaty_type_type_and_treaty_type_id", using: :btree

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

  create_table "warrant_badges", force: :cascade do |t|
    t.integer "warrant_type_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  add_index "warrant_badges", ["warrant_type_id"], name: "index_warrant_badges_on_warrant_type_id", using: :btree

  create_table "warrant_types", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "warrant_badge_file_name"
    t.string   "warrant_badge_content_type"
    t.integer  "warrant_badge_file_size"
    t.datetime "warrant_badge_updated_at"
    t.boolean  "missive"
    t.integer  "stallari_order"
    t.text     "job_description"
    t.integer  "superior_warrant_id"
    t.boolean  "background_check_required"
    t.boolean  "northwatch_display"
    t.string   "icon_file_name"
    t.boolean  "active"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "warrant_types", ["superior_warrant_id"], name: "index_warrant_types_on_superior_warrant_id", using: :btree

  create_table "warrants", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "warrant_type_id"
    t.datetime "tenure_start"
    t.datetime "tenure_end"
    t.integer  "branch_id"
    t.datetime "approved"
    t.text     "introduction"
    t.text     "comments"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "warrants", ["branch_id"], name: "index_warrants_on_branch_id", using: :btree
  add_index "warrants", ["person_id"], name: "index_warrants_on_person_id", using: :btree
  add_index "warrants", ["warrant_type_id"], name: "index_warrants_on_warrant_type_id", using: :btree

  add_foreign_key "authorization_cards", "users"
  add_foreign_key "authorizations", "authorization_types"
  add_foreign_key "authorizations", "people"
  add_foreign_key "award_recipient_recommendations", "award_recipients"
  add_foreign_key "award_recipient_recommendations", "award_recommendations"
  add_foreign_key "award_recipients", "awards"
  add_foreign_key "award_recipients", "courts"
  add_foreign_key "award_recipients", "personas"
  add_foreign_key "award_recommendations", "awards"
  add_foreign_key "award_recommendations", "branches"
  add_foreign_key "award_recommendations", "personas"
  add_foreign_key "award_scribes", "award_recipients"
  add_foreign_key "award_scribes", "people"
  add_foreign_key "branches", "branch_types"
  add_foreign_key "branches", "branches", column: "parent_branch_id", on_delete: :nullify
  add_foreign_key "champions", "personas"
  add_foreign_key "champions", "reigns"
  add_foreign_key "courts", "events"
  add_foreign_key "courts", "reigns"
  add_foreign_key "event_attendees", "award_recommendations"
  add_foreign_key "event_attendees", "events"
  add_foreign_key "event_attendees", "personas"
  add_foreign_key "event_attendees", "warrant_types"
  add_foreign_key "events", "addresses"
  add_foreign_key "events", "branches"
  add_foreign_key "events", "branches", column: "sponsor_branch_id"
  add_foreign_key "events", "events", column: "superseded_by_id", on_delete: :nullify
  add_foreign_key "events", "events", column: "supersedes_id", on_delete: :nullify
  add_foreign_key "events", "personas", column: "steward_persona_id", on_delete: :nullify
  add_foreign_key "events", "personas", column: "submitter_persona_id", on_delete: :nullify
  add_foreign_key "peer_candidate_comments", "peer_candidates"
  add_foreign_key "peer_candidate_comments", "people"
  add_foreign_key "peer_candidates", "awards"
  add_foreign_key "peer_candidates", "personas"
  add_foreign_key "people", "addresses"
  add_foreign_key "people", "branches"
  add_foreign_key "people", "users", on_delete: :nullify
  add_foreign_key "personas", "persona_types"
  add_foreign_key "personas", "users", on_delete: :nullify
  add_foreign_key "poll_answers", "polls"
  add_foreign_key "warrants", "branches"
  add_foreign_key "warrants", "people"
  add_foreign_key "warrants", "warrant_types"
end
