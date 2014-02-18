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

ActiveRecord::Schema.define(:version => 20140218190248) do

  create_table "assignees", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "text"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "commenter_id"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.string   "content"
    t.integer  "task_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sender_id"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.date     "expiration_date"
    t.string   "notification"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "category"
    t.datetime "read_date"
  end

  create_table "offers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "task_id"
  end

  create_table "reports", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.integer  "status"
    t.string   "description"
    t.spatial  "start_xy",       :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.spatial  "end_xy",         :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "created_at",                                                                 :null => false
    t.datetime "updated_at",                                                                 :null => false
    t.integer  "user_id"
    t.string   "start_loc"
    t.string   "end_loc"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "estimated_time"
    t.datetime "deleted_at"
    t.integer  "points",         :limit => 8
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "points"
    t.string   "provider"
    t.string   "uid"
  end

end
