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

ActiveRecord::Schema.define(version: 20140422071715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  create_table "registrants", force: true do |t|
    t.string "email"
    t.string "registration_code"
    t.datetime "registration_expires_at"
  end

  create_table "apprenticeships", force: true do |t|
    t.datetime "end_date",      null: false
    t.integer  "master_id"
    t.integer  "apprentice_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "apprenticeships", ["apprentice_id"], name: "index_apprenticeships_on_apprentice_id", using: :btree
  add_index "apprenticeships", ["master_id"], name: "index_apprenticeships_on_master_id", using: :btree

  create_table "conversations", force: true do |t|
    t.integer  "created_by"
    t.integer  "created_for"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.integer  "conversation_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "proficiencies", force: true do |t|
    t.integer "user_id"
    t.integer "skill_id"
    t.string  "proficiency_status"
  end

  create_table "ratings", force: true do |t|
    t.integer  "rater_id"
    t.integer  "ratee_id"
    t.integer  "apprenticeship_id"
    t.integer  "rating"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "ratings", ["apprenticeship_id"], name: "index_ratings_on_apprenticeship_id", using: :btree
  add_index "ratings", ["ratee_id"], name: "index_ratings_on_ratee_id", using: :btree
  add_index "ratings", ["rater_id"], name: "index_ratings_on_rater_id", using: :btree

  create_table "registrants", force: true do |t|
    t.string   "email"
    t.string   "registration_code"
    t.datetime "registration_expires_at"
  end

  create_table "skills", force: true do |t|
    t.string "skill_name"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "salt"
    t.string   "fish"
    t.string   "reset_code"
    t.datetime "reset_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.boolean  "is_active"
    t.string   "username"
    t.string   "about_me"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
