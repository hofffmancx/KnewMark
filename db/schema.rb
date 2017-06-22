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

ActiveRecord::Schema.define(version: 20170615013827) do

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

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
  end

  create_table "anwsers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "friendly_id"
    t.index ["friendly_id"], name: "index_anwsers_on_friendly_id", unique: true
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

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "likes_count", default: 0
    t.string   "friendly_id"
    t.index ["friendly_id"], name: "index_comments_on_friendly_id", unique: true
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.text     "content"
    t.integer  "knowledge_id"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "likes_count",  default: 0
    t.string   "friendly_id"
    t.index ["friendly_id"], name: "index_discussions_on_friendly_id", unique: true
    t.index ["knowledge_id"], name: "index_discussions_on_knowledge_id"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "creator_id"
    t.integer  "knowledge_id"
    t.string   "action"
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.integer  "ownerable_id"
    t.string   "ownerable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["eventable_id", "eventable_type"], name: "index_events_on_eventable_id_and_eventable_type"
    t.index ["knowledge_id"], name: "index_events_on_knowledge_id"
    t.index ["ownerable_id", "ownerable_type"], name: "index_events_on_ownerable_id_and_ownerable_type"
  end

  create_table "knowledges", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "description"
    t.text     "appropriate"
    t.text     "notice"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "is_hidden",         default: true
    t.string   "status",            default: "hidden"
    t.integer  "category_id"
    t.integer  "likes_count",       default: 0
    t.integer  "marks_count",       default: 0
    t.integer  "follows_count",     default: 0
    t.integer  "wants_count",       default: 0
    t.integer  "haves_count",       default: 0
    t.integer  "reviews_count",     default: 0,        null: false
    t.integer  "discussions_count", default: 0,        null: false
    t.integer  "questions_count",   default: 0,        null: false
    t.integer  "user_id"
    t.string   "friendly_id"
    t.integer  "events_count",      default: 0
    t.index ["friendly_id"], name: "index_knowledges_on_friendly_id", unique: true
    t.index ["title"], name: "index_knowledges_on_title"
  end

  create_table "knowledges_tags", force: :cascade do |t|
    t.integer "knowledge_id"
    t.integer "tag_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",            null: false
    t.integer  "actor_id"
    t.string   "notify_type",        null: false
    t.string   "target_type"
    t.integer  "target_id"
    t.string   "second_target_type"
    t.integer  "second_target_id"
    t.string   "third_target_type"
    t.integer  "third_target_id"
    t.datetime "read_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["user_id", "notify_type"], name: "index_notifications_on_user_id_and_notify_type"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "knowledge_id"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.index ["knowledge_id"], name: "index_photos_on_knowledge_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "gender"
    t.date     "birthday"
    t.string   "location"
    t.string   "website"
    t.text     "self_introduction"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "knowledge_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "anwsers_count", default: 0, null: false
    t.string   "friendly_id"
    t.index ["friendly_id"], name: "index_questions_on_friendly_id", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "knowledge_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "comments_count", default: 0, null: false
    t.integer  "likes_count",    default: 0
    t.string   "friendly_id"
    t.index ["friendly_id"], name: "index_reviews_on_friendly_id", unique: true
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

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "role",                            default: "user"
    t.integer  "like_knowledges_count",           default: 0
    t.integer  "mark_knowledges_count",           default: 0
    t.integer  "follow_knowledges_count",         default: 0
    t.integer  "followers_count",                 default: 0
    t.integer  "following_count",                 default: 0
    t.integer  "want_knowledges_count",           default: 0
    t.integer  "have_knowledges_count",           default: 0
    t.integer  "reviews_count",                   default: 0,      null: false
    t.integer  "discussions_count",               default: 0,      null: false
    t.integer  "comments_count",                  default: 0,      null: false
    t.integer  "like_comments_count",             default: 0
    t.integer  "like_reviews_count",              default: 0
    t.integer  "like_discussions_count",          default: 0
    t.integer  "questions_count",                 default: 0,      null: false
    t.integer  "anwsers_count",                   default: 0,      null: false
    t.string   "cellphone"
    t.string   "avatar"
    t.string   "username"
    t.string   "friendly_id"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["cellphone"], name: "index_users_on_cellphone"
    t.index ["email"], name: "index_users_on_email"
    t.index ["friendly_id"], name: "index_users_on_friendly_id", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["role"], name: "index_users_on_role"
  end

  create_table "verify_tokens", force: :cascade do |t|
    t.string   "token"
    t.string   "cellphone"
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cellphone", "token"], name: "index_verify_tokens_on_cellphone_and_token"
  end

end
