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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130713071023) do

  create_table "about_us", :force => true do |t|
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deleted_at"
  end

  create_table "ages", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "value"
  end

  create_table "article_plannings", :force => true do |t|
    t.integer  "article_id"
    t.integer  "planning_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "outline"
    t.integer  "theme_id"
    t.integer  "vihicle_id"
    t.integer  "member_id"
    t.integer  "purpose_id"
    t.integer  "budget_id"
    t.integer  "language_id"
    t.integer  "age_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "deleted_at"
    t.boolean  "approved"
    t.integer  "user_id"
    t.boolean  "recommended"
    t.integer  "country_id"
    t.integer  "image_id"
  end

  create_table "budgets", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "value"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deleted_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "code"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "deleted_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "value"
  end

  create_table "members", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "value"
  end

  create_table "paragraphs", :force => true do |t|
    t.integer  "article_id"
    t.string   "subtitle"
    t.string   "sentence"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deleted_at"
    t.integer  "image_id"
  end

  create_table "plannings", :force => true do |t|
    t.string   "name"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.text     "photo"
    t.text     "about"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "purposes", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "value"
  end

  create_table "readers", :force => true do |t|
    t.integer  "article_id"
    t.integer  "date"
    t.string   "deviceregion"
    t.string   "visitorregion"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "last_article_id"
  end

  create_table "socials", :force => true do |t|
    t.text     "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "provider"
  end

  create_table "themes", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "value"
    t.string   "color"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "uid"
    t.string   "provider"
    t.datetime "deleted_at"
    t.string   "name"
    t.string   "gender"
    t.string   "user_type"
    t.integer  "social_id"
    t.string   "link"
    t.string   "image_url"
    t.text     "bio"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vihicles", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "value"
  end

  create_table "visitors", :force => true do |t|
    t.integer  "date"
    t.string   "deviceregion"
    t.string   "visitorregion"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
