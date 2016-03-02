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

ActiveRecord::Schema.define(version: 20160302021357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.text     "content",          null: false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "title",               null: false
    t.text     "description"
    t.float    "total_votes_percent", null: false
    t.float    "agree_votes_percent", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "slug",                null: false
  end

  add_index "groups", ["parent_id"], name: "index_groups_on_parent_id", using: :btree
  add_index "groups", ["slug", "parent_id"], name: "index_groups_on_slug_and_parent_id", unique: true, using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.string   "email",                      null: false
    t.string   "token",                      null: false
    t.boolean  "registered", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "invitations", ["email"], name: "index_invitations_on_email", unique: true, using: :btree
  add_index "invitations", ["token"], name: "index_invitations_on_token", unique: true, using: :btree

  create_table "join_requirements", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.string   "key",                             null: false
    t.json     "data",                            null: false
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.boolean  "read",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id", using: :btree

  create_table "proposals", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "parent_id"
    t.integer  "section_id", null: false
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "proposals", ["section_id", "parent_id", "user_id"], name: "index_proposals_on_section_id_and_parent_id_and_user_id", using: :btree

  create_table "references", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "proposal_id", null: false
    t.string   "title",       null: false
    t.string   "content",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "references", ["user_id", "proposal_id"], name: "index_references_on_user_id_and_proposal_id", unique: true, using: :btree

  create_table "requirement_values", force: :cascade do |t|
    t.integer  "user_id",             null: false
    t.integer  "join_requirement_id", null: false
    t.string   "value",               null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "requirement_values", ["user_id", "join_requirement_id"], name: "index_requirement_values_on_user_id_and_join_requirement_id", unique: true, using: :btree

  create_table "requirements", force: :cascade do |t|
    t.integer "join_requirement_id", null: false
    t.integer "requirable_id"
    t.string  "requirable_type"
  end

  add_index "requirements", ["requirable_id", "requirable_type", "join_requirement_id"], name: "requirements_index", unique: true, using: :btree
  add_index "requirements", ["requirable_type", "requirable_id"], name: "index_requirements_on_requirable_type_and_requirable_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.integer  "topic_id",   null: false
    t.integer  "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sections", ["topic_id", "index"], name: "index_sections_on_topic_id_and_index", unique: true, using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",            null: false
    t.string   "role"
    t.integer  "subscriptable_id"
    t.string   "subscriptable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "subscriptions", ["subscriptable_type", "subscriptable_id"], name: "index_subscriptions_on_subscriptable_type_and_subscriptable_id", using: :btree
  add_index "subscriptions", ["user_id", "subscriptable_id", "subscriptable_type"], name: "subscriptions_index", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "team_invitations", force: :cascade do |t|
    t.integer  "team_id",                    null: false
    t.string   "email",                      null: false
    t.string   "token",                      null: false
    t.boolean  "accepted",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "team_invitations", ["email", "team_id"], name: "index_team_invitations_on_email_and_team_id", unique: true, using: :btree
  add_index "team_invitations", ["token"], name: "index_team_invitations_on_token", unique: true, using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "title",                      null: false
    t.boolean  "public",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug",                       null: false
  end

  add_index "teams", ["slug"], name: "index_teams_on_slug", unique: true, using: :btree

  create_table "topics", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "parent_id"
    t.integer  "team_id"
    t.integer  "group_id",   null: false
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topics", ["parent_id"], name: "index_topics_on_parent_id", using: :btree
  add_index "topics", ["user_id", "parent_id", "group_id"], name: "index_topics_on_user_id_and_parent_id_and_group_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",                          null: false
    t.string   "email",                             null: false
    t.string   "encrypted_password",    limit: 128, null: false
    t.string   "confirmation_token",    limit: 128
    t.string   "remember_token",        limit: 128, null: false
    t.integer  "available_invitations"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "proposal_id", null: false
    t.integer  "opinion",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "votes", ["user_id", "proposal_id"], name: "index_votes_on_user_id_and_proposal_id", unique: true, using: :btree

  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "users"
  add_foreign_key "groups", "groups", column: "parent_id"
  add_foreign_key "invitations", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "proposals", "proposals", column: "parent_id"
  add_foreign_key "proposals", "sections"
  add_foreign_key "proposals", "users"
  add_foreign_key "references", "proposals"
  add_foreign_key "references", "users"
  add_foreign_key "requirement_values", "join_requirements"
  add_foreign_key "requirement_values", "users"
  add_foreign_key "requirements", "join_requirements"
  add_foreign_key "sections", "topics"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "topics", "groups"
  add_foreign_key "topics", "teams"
  add_foreign_key "topics", "topics", column: "parent_id"
  add_foreign_key "topics", "users"
  add_foreign_key "votes", "proposals"
  add_foreign_key "votes", "users"
end
