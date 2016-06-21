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

ActiveRecord::Schema.define(version: 20160621204908) do

  create_table "announcements", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "attachment",  limit: 255
    t.date     "due_date"
    t.integer  "course_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "course_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "attachment", limit: 255
    t.integer  "chapter_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name",          limit: 255,   null: false
    t.text     "description",   limit: 65535, null: false
    t.string   "privacy",       limit: 255,   null: false
    t.text     "tags",          limit: 65535, null: false
    t.text     "objectives",    limit: 65535, null: false
    t.integer  "owner_id",      limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "prerequisites", limit: 65535
  end

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.integer "course_id", limit: 4
  end

  add_index "courses_users", ["user_id", "course_id"], name: "index_courses_users_on_user_id_and_course_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",   limit: 4,                   null: false
    t.string   "followable_type", limit: 255,                 null: false
    t.integer  "follower_id",     limit: 4,                   null: false
    t.string   "follower_type",   limit: 255,                 null: false
    t.boolean  "blocked",                     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "interests", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "interests_users", id: false, force: :cascade do |t|
    t.integer "interest_id", limit: 4
    t.integer "user_id",     limit: 4
  end

  add_index "interests_users", ["interest_id"], name: "index_interests_users_on_interest_id", using: :btree
  add_index "interests_users", ["user_id"], name: "index_interests_users_on_user_id", using: :btree

  create_table "join_requests", force: :cascade do |t|
    t.integer  "course_id",    limit: 4
    t.integer  "requester_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "quiz_id",           limit: 4
    t.text     "question",          limit: 65535
    t.integer  "number_of_options", limit: 4
    t.float    "weight",            limit: 24,    default: 1.0
    t.string   "answer1",           limit: 255
    t.string   "answer2",           limit: 255
    t.string   "answer3",           limit: 255
    t.string   "answer4",           limit: 255
    t.string   "answer5",           limit: 255
    t.string   "answer6",           limit: 255
    t.string   "answer7",           limit: 255
    t.string   "answer8",           limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.string   "name",       limit: 255
    t.date     "due_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "solutions", force: :cascade do |t|
    t.string   "attachment",    limit: 255
    t.integer  "course_id",     limit: 4
    t.integer  "assignment_id", limit: 4
    t.integer  "student_id",    limit: 4
    t.float    "grade",         limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "solutions", ["course_id", "assignment_id", "student_id"], name: "index_solutions_on_course_id_and_assignment_id_and_student_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",           null: false
    t.string   "encrypted_password",     limit: 255, default: "",           null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "is_admin",               limit: 4,   default: 0
    t.date     "birthdate",                          default: '2015-01-01'
    t.string   "jobtitle",               limit: 255, default: "N/A"
    t.string   "gender",                 limit: 255, default: "N/A"
    t.string   "address",                limit: 255, default: "N/A"
    t.string   "bio",                    limit: 255, default: "N/A"
    t.string   "avatar",                 limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
