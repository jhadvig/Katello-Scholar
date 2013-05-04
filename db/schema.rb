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

ActiveRecord::Schema.define(:version => 20130504150224) do

  create_table "architectures", :force => true do |t|
    t.string   "name"
    t.integer  "foreman_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "foreman_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "labs", :force => true do |t|
    t.string   "name"
    t.text     "info"
    t.integer  "status"
    t.integer  "lesson_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "foreman_subnet_id"
    t.string   "network"
    t.string   "netmask"
  end

  create_table "lessons", :force => true do |t|
    t.integer  "number"
    t.boolean  "status"
    t.text     "info"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "seminar_id"
    t.integer  "template_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "day"
    t.integer  "lab_id"
    t.integer  "foreman_hostgroup_id"
  end

  create_table "operating_systems", :force => true do |t|
    t.string   "name"
    t.string   "major"
    t.string   "minor"
    t.string   "path"
    t.string   "os_family"
    t.integer  "architecture_id"
    t.integer  "foreman_medium_id"
    t.integer  "foreman_os_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "full_name"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "seminars", :force => true do |t|
    t.integer  "seminar_number"
    t.integer  "day"
    t.time     "starts_at"
    t.time     "ends_at"
    t.text     "info"
    t.integer  "course_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "lab_id"
  end

  create_table "seminars_users", :id => false, :force => true do |t|
    t.integer "seminar_id"
    t.integer "user_id"
  end

  create_table "system_guests", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "lesson_id"
    t.integer  "foreman_host_id"
    t.integer  "system_host_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "status"
  end

  create_table "system_hosts", :force => true do |t|
    t.string   "name"
    t.string   "ip"
    t.string   "mac"
    t.string   "domain"
    t.integer  "status"
    t.integer  "lab_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.string   "info"
    t.integer  "course_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "operating_system_id"
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
