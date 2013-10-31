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

ActiveRecord::Schema.define(version: 20121026013909) do

  create_table "tweets", force: true do |t|
    t.string   "tweet_id"
    t.string   "tweet_text"
    t.string   "username"
    t.string   "media_url"
    t.string   "image"
    t.string   "media_display_url"
    t.string   "thumb_file_name"
    t.integer  "retweet_count"
    t.datetime "published_at"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
