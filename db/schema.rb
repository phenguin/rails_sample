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

ActiveRecord::Schema.define(:version => 20120131173213) do

  create_table "affiliations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",      :default => false
  end

  add_index "affiliations", ["user_id", "group_id"], :name => "index_affiliations_on_user_id_and_group_id", :unique => true

  create_table "article_topics", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_topics", :force => true do |t|
    t.integer  "group_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", :force => true do |t|
    t.integer  "week_id"
    t.string   "name"
    t.string   "description"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "materials", ["week_id"], :name => "index_materials_on_week_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "week_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"
  add_index "posts", ["week_id"], :name => "index_posts_on_week_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["user_id", "topic_id"], :name => "index_subscriptions_on_user_id_and_topic_id", :unique => true

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_articles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "read_date"
  end

  add_index "user_articles", ["read_date"], :name => "index_user_articles_on_read_date"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "weeks", :force => true do |t|
    t.integer  "group_id"
    t.integer  "week_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weeks", ["group_id", "week_number"], :name => "index_weeks_on_group_id_and_week_number", :unique => true

end
