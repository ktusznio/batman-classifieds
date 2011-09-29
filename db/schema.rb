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

ActiveRecord::Schema.define(:version => 20110827194535) do

  create_table "ad_state_transitions", :force => true do |t|
    t.integer   "ad_id"
    t.string    "event"
    t.string    "from"
    t.string    "to"
    t.timestamp "created_at"
  end

  create_table "ads", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "title"
    t.string    "sale_type",   :default => "fixed"
    t.decimal   "price"
    t.text      "description"
    t.integer   "user_id"
    t.string    "state"
    t.boolean   "best_offer"
  end

  add_index "ads", ["state", "sale_type"], :name => "index_ads_on_state_and_sale_type"

  create_table "delayed_jobs", :force => true do |t|
    t.integer   "priority",   :default => 0
    t.integer   "attempts",   :default => 0
    t.text      "handler"
    t.text      "last_error"
    t.timestamp "run_at"
    t.timestamp "locked_at"
    t.timestamp "failed_at"
    t.text      "locked_by"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer   "ad_id"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "images", ["ad_id"], :name => "index_images_on_ad_id"

  create_table "users", :force => true do |t|
    t.string    "uid"
    t.string    "email"
    t.string    "first_name"
    t.string    "last_name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["uid"], :name => "index_users_on_uid"

end
