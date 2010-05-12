# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100512080938) do

  create_table "attachments", :force => true do |t|
    t.integer  "content_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["content_id"], :name => "index_attachments_on_content_id"

  create_table "authors", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",                                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authors", ["username"], :name => "index_authors_on_username", :unique => true

  create_table "blocks", :force => true do |t|
    t.string   "block_type"
    t.string   "title_en"
    t.string   "title_it"
    t.integer  "content_id"
    t.boolean  "show_title"
    t.integer  "block_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "label_it",   :null => false
    t.string   "label_en",   :null => false
    t.string   "url_alias",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["url_alias"], :name => "index_categories_on_url_alias", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "content_id"
    t.string   "user_name"
    t.string   "user_email"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", :force => true do |t|
    t.string   "title_en",     :null => false
    t.string   "title_it",     :null => false
    t.integer  "author_id",    :null => false
    t.string   "url_alias",    :null => false
    t.text     "content_it",   :null => false
    t.text     "content_en",   :null => false
    t.text     "summary_it"
    t.text     "summary_en"
    t.integer  "category_id",  :null => false
    t.boolean  "published"
    t.boolean  "has_comments"
    t.boolean  "in_home"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "image_id"
  end

  add_index "contents", ["author_id"], :name => "index_contents_on_author_id"
  add_index "contents", ["category_id"], :name => "index_contents_on_category_id"
  add_index "contents", ["url_alias"], :name => "index_contents_on_url_alias", :unique => true

  create_table "contents_tags", :id => false, :force => true do |t|
    t.integer "tag_id",     :null => false
    t.integer "content_id", :null => false
  end

  add_index "contents_tags", ["tag_id", "content_id"], :name => "index_contents_tags_on_tag_id_and_content_id", :unique => true

  create_table "images", :force => true do |t|
    t.string   "content_file_name"
    t.string   "content_content_type"
    t.integer  "content_file_size"
    t.datetime "content_updated_at"
    t.string   "title_en"
    t.string   "title_it"
    t.string   "url_alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", :force => true do |t|
    t.string   "menu_type"
    t.string   "title_en"
    t.string   "title_it"
    t.string   "url"
    t.integer  "menu_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tags", :force => true do |t|
    t.string "label_it",  :null => false
    t.string "label_en",  :null => false
    t.string "url_alias"
  end

  add_index "tags", ["label_en"], :name => "index_tags_on_label_en", :unique => true
  add_index "tags", ["label_it"], :name => "index_tags_on_label_it", :unique => true

end
