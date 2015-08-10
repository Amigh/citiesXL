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

ActiveRecord::Schema.define(version: 20150806120334) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "medalizations", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "medal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medals", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "score"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "type_name"
    t.string   "display_name"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "population"
    t.integer  "cash_flow"
    t.integer  "income"
    t.integer  "money"
    t.integer  "satis_people_1"
    t.integer  "satis_people_2"
    t.integer  "satis_people_3"
    t.integer  "satis_people_4"
    t.integer  "satis_work_1"
    t.integer  "satis_work_2"
    t.integer  "satis_work_3"
    t.integer  "satis_work_4"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "student_id"
    t.integer  "satis_shop"
    t.integer  "satis_env"
    t.integer  "satis_services"
    t.integer  "satis_freight"
    t.integer  "satis_trafic"
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.integer  "score"
    t.string   "class_name"
    t.integer  "class_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "year"
  end

end
