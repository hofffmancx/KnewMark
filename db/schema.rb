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

ActiveRecord::Schema.define(version: 20170525005704) do

  create_table "actions", force: :cascade do |t|
    t.string   "action_type",   null: false
    t.string   "action_option"
    t.string   "target_type"
    t.integer  "target_id"
    t.string   "user_type"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["target_type", "target_id", "action_type"], name: "index_actions_on_target_type_and_target_id_and_action_type"
    t.index ["user_type", "user_id", "action_type"], name: "index_actions_on_user_type_and_user_id_and_action_type"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.integer  "weight",             default: 0
    t.integer  "knowledges_counter", default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["title"], name: "index_categories_on_title"
  end

  create_table "knowledges", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "description"
    t.text     "appropriate"
    t.text     "notice"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "is_hidden",     default: true
    t.string   "status",        default: "hidden"
    t.integer  "likes_count",   default: 0
    t.integer  "stars_count",   default: 0
    t.integer  "follows_count", default: 0
    t.integer  "category_id"
    t.index ["title"], name: "index_knowledges_on_title"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "knowledge_id"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["knowledge_id"], name: "index_photos_on_knowledge_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "knowledge_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["knowledge_id"], name: "index_reviews_on_knowledge_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "knowledge_id"
    t.integer  "score"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["knowledge_id"], name: "index_scores_on_knowledge_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.boolean  "is_admin",                        default: false
    t.integer  "like_knowledge_count",            default: 0
    t.integer  "star_knowledge_count",            default: 0
    t.integer  "like_knowledges_count",           default: 0
    t.integer  "star_knowledges_count",           default: 0
    t.integer  "follow_knowledges_count",         default: 0
    t.integer  "followers_count",                 default: 0
    t.integer  "following_count",                 default: 0
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

end
