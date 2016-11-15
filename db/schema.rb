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

ActiveRecord::Schema.define(version: 20161115000106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domain_lookups", force: :cascade do |t|
    t.integer  "domain_id"
    t.datetime "timestamp"
    t.jsonb    "nameservers"
    t.string   "a_record"
    t.string   "mx_record"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["domain_id"], name: "index_domain_lookups_on_domain_id", using: :btree
  end

  create_table "domain_stats", force: :cascade do |t|
    t.integer  "domain_id"
    t.jsonb    "stat"
    t.jsonb    "disk_usage"
    t.bigint   "total_size"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_domain_stats_on_domain_id", using: :btree
  end

  create_table "domains", force: :cascade do |t|
    t.integer  "plesk_server_id"
    t.inet     "ip_address"
    t.boolean  "is_ssl"
    t.string   "ftp_username"
    t.string   "ftp_password"
    t.string   "status"
    t.integer  "plesk_id"
    t.string   "hosting_type"
    t.string   "name"
    t.string   "redirect_to"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "last_updated_at"
    t.date     "plesk_created_date"
    t.jsonb    "last_packet"
    t.index ["last_updated_at"], name: "index_domains_on_last_updated_at", using: :btree
    t.index ["name"], name: "index_domains_on_name", using: :btree
    t.index ["plesk_server_id"], name: "index_domains_on_plesk_server_id", using: :btree
  end

  create_table "pagespeed_tests", force: :cascade do |t|
    t.integer  "domain_id"
    t.datetime "timestamp"
    t.integer  "speed_score"
    t.integer  "usability_score"
    t.boolean  "has_viewport"
    t.jsonb    "test"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["domain_id"], name: "index_pagespeed_tests_on_domain_id", using: :btree
  end

  create_table "plesk_server_stats", force: :cascade do |t|
    t.integer  "plesk_server_id"
    t.datetime "timestamp"
    t.integer  "domains"
    t.integer  "active_domains"
    t.string   "plesk_version"
    t.jsonb    "load_avg"
    t.jsonb    "mem"
    t.jsonb    "diskspace"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["plesk_server_id"], name: "index_plesk_server_stats_on_plesk_server_id", using: :btree
  end

  create_table "plesk_servers", force: :cascade do |t|
    t.string   "name"
    t.string   "host"
    t.inet     "primary_ip"
    t.string   "plesk_version"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "domain_lookups", "domains"
  add_foreign_key "domain_stats", "domains"
  add_foreign_key "domains", "plesk_servers"
  add_foreign_key "pagespeed_tests", "domains"
  add_foreign_key "plesk_server_stats", "plesk_servers"
end
