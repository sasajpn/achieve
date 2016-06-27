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

ActiveRecord::Schema.define(version: 20160626180308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "blog_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content"
  end

  add_index "comments", ["blog_id"], name: "index_comments_on_blog_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "goodjobs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "goodjobs", ["task_id"], name: "index_goodjobs_on_task_id", using: :btree
  add_index "goodjobs", ["user_id"], name: "index_goodjobs_on_user_id", using: :btree

  create_table "helps", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_relations", force: :cascade do |t|
    t.integer  "inviting_id"
    t.integer  "invited_id"
    t.integer  "approving_id"
    t.integer  "approved_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "project_relations", ["approved_id"], name: "index_project_relations_on_approved_id", using: :btree
  add_index "project_relations", ["approving_id", "approved_id"], name: "index_project_relations_on_approving_id_and_approved_id", unique: true, using: :btree
  add_index "project_relations", ["approving_id"], name: "index_project_relations_on_approving_id", using: :btree
  add_index "project_relations", ["invited_id"], name: "index_project_relations_on_invited_id", using: :btree
  add_index "project_relations", ["inviting_id", "invited_id"], name: "index_project_relations_on_inviting_id_and_invited_id", unique: true, using: :btree
  add_index "project_relations", ["inviting_id"], name: "index_project_relations_on_inviting_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "information"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "admin_user_id", null: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "task_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "task_comments", ["task_id"], name: "index_task_comments_on_task_id", using: :btree
  add_index "task_comments", ["user_id"], name: "index_task_comments_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.string   "title"
    t.text     "content"
    t.datetime "deadline"
    t.integer  "charge_id",              null: false
    t.boolean  "done",                   null: false
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "project_id"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name",                   default: "", null: false
    t.text     "profile"
    t.string   "uid",                    default: "", null: false
    t.string   "provider",               default: "", null: false
    t.string   "image_url"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "comments", "blogs"
  add_foreign_key "comments", "users"
  add_foreign_key "goodjobs", "tasks"
  add_foreign_key "goodjobs", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "task_comments", "tasks"
  add_foreign_key "task_comments", "users"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users"
end
