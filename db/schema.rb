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

ActiveRecord::Schema.define(version: 20160131074816) do

  create_table "collections", force: :cascade do |t|
    t.string   "area_new3",                  limit: 255
    t.string   "area_arm_2",                 limit: 255
    t.string   "bran_br_name",               limit: 255
    t.integer  "contractno",                 limit: 4
    t.integer  "kode_cabang",                limit: 4
    t.string   "objtdesc",                   limit: 255
    t.float    "bal_prin",                   limit: 24
    t.integer  "arec_appl_no",               limit: 4
    t.integer  "days",                       limit: 4
    t.string   "bucket",                     limit: 255
    t.datetime "reqdate"
    t.string   "nama_remedia",               limit: 255
    t.datetime "jatuh_tempo_ang_tertunggak"
    t.integer  "installment_no",             limit: 4
    t.string   "area_collection",            limit: 255
    t.string   "collector_name",             limit: 255
    t.string   "cust_name",                  limit: 255
    t.boolean  "status",                     limit: 1,   default: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

end
