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

ActiveRecord::Schema.define(version: 20180417230609) do

  create_table "allusers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.string "prefix"
    t.string "name"
    t.string "surname"
    t.string "cardnumber"
    t.string "position"
    t.string "phone"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_id"
    t.integer "role_id"
    t.index ["email"], name: "index_allusers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_allusers_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_allusers_on_role_id"
    t.index ["school_id"], name: "index_allusers_on_school_id"
  end

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

  create_table "models", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_models_on_email", unique: true
    t.index ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true
  end

  create_table "musicins", force: :cascade do |t|
    t.string "title"
    t.integer "formtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "orderno"
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
    t.integer "musicin_id"
    t.index ["musicin_id"], name: "index_questions_on_musicin_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "education_area"
    t.string "ministry_code"
    t.string "school_name"
    t.string "municipal_area"
    t.string "district"
    t.string "province"
    t.string "postcode"
    t.integer "zone"
    t.integer "students_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "teacherpositions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacherstatuses", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachertopics", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacheruniversities", force: :cascade do |t|
    t.string "title"
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
    t.string "prefix"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["school_id"], name: "index_users_on_school_id"
  end

end
