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

ActiveRecord::Schema.define(version: 20180411052434) do

  create_table "answers", force: :cascade do |t|
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.integer "school_id"
    t.string "answer2"
    t.integer "musicin_id"
    t.string "othertitle"
    t.index ["musicin_id"], name: "index_answers_on_musicin_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["school_id"], name: "index_answers_on_school_id"
  end

  create_table "loghistories", force: :cascade do |t|
    t.string "behavior"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "question_id"
    t.string "answer2"
    t.integer "musicin_id"
    t.string "othertitle"
    t.index ["musicin_id"], name: "index_loghistories_on_musicin_id"
    t.index ["question_id"], name: "index_loghistories_on_question_id"
    t.index ["user_id"], name: "index_loghistories_on_user_id"
  end

  create_table "logmusicteachers", force: :cascade do |t|
    t.string "prefix"
    t.string "name"
    t.string "surname"
    t.string "status"
    t.string "position"
    t.string "degree"
    t.string "branch"
    t.string "university"
    t.string "topic"
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "schools_id"
    t.integer "users_id"
    t.string "behavior"
    t.index ["schools_id"], name: "index_logmusicteachers_on_schools_id"
    t.index ["users_id"], name: "index_logmusicteachers_on_users_id"
  end

  create_table "musicins", force: :cascade do |t|
    t.string "title"
    t.integer "formtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "musicteachers", force: :cascade do |t|
    t.string "prefix"
    t.string "name"
    t.string "surname"
    t.string "status"
    t.string "position"
    t.string "degree"
    t.string "branch"
    t.string "university"
    t.string "topic"
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "schools_id"
    t.index ["schools_id"], name: "index_musicteachers_on_schools_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "choice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qtype"
    t.boolean "isrequire"
    t.integer "musicin_id"
    t.index ["musicin_id"], name: "index_questions_on_musicin_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "todo_list_id"
    t.string "name"
    t.boolean "completed"
    t.date "due"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_list_id"], name: "index_tasks_on_todo_list_id"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.string "Name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_id"
    t.integer "role_id"
    t.string "name"
    t.string "lastname"
    t.string "cardnumber"
    t.string "position"
    t.string "phone"
    t.string "email"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["school_id"], name: "index_users_on_school_id"
  end

end
