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

ActiveRecord::Schema.define(version: 2019_09_25_143415) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "amounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "sheet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_amounts_on_user_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tell_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tell_id"], name: "index_comments_on_tell_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "rate_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rate_id"], name: "index_evaluations_on_rate_id"
    t.index ["user_id", "rate_id"], name: "index_evaluations_on_user_id_and_rate_id", unique: true
    t.index ["user_id"], name: "index_evaluations_on_user_id"
  end

  create_table "exchangepoints", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "give_id"
    t.bigint "issue_id"
    t.bigint "give_issue_id"
    t.integer "give_point"
    t.integer "get_point"
    t.integer "give_nomal_point"
    t.integer "get_nomal_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["give_id"], name: "index_exchangepoints_on_give_id"
    t.index ["give_issue_id"], name: "index_exchangepoints_on_give_issue_id"
    t.index ["issue_id"], name: "index_exchangepoints_on_issue_id"
    t.index ["user_id"], name: "index_exchangepoints_on_user_id"
  end

  create_table "havethings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "search_word"
    t.index ["user_id"], name: "index_havethings_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "talk_id"
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notification", default: false, null: false
    t.integer "kind"
    t.index ["talk_id"], name: "index_messages_on_talk_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "nomalpoints", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "issue_id"
    t.integer "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_nomalpoints_on_issue_id"
    t.index ["user_id"], name: "index_nomalpoints_on_user_id"
  end

  create_table "point_confirmations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "user_id"
    t.bigint "give_id"
    t.bigint "give_issue_id"
    t.bigint "get_issue_id"
    t.integer "give_point"
    t.integer "get_point"
    t.integer "give_nomal_point"
    t.integer "get_nomal_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "answered", default: false, null: false
    t.index ["get_issue_id"], name: "index_point_confirmations_on_get_issue_id"
    t.index ["give_id"], name: "index_point_confirmations_on_give_id"
    t.index ["give_issue_id"], name: "index_point_confirmations_on_give_issue_id"
    t.index ["message_id"], name: "index_point_confirmations_on_message_id"
    t.index ["user_id"], name: "index_point_confirmations_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "user_path"
    t.text "text"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wantthings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wantthings_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "amounts", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "users", column: "tell_id"
  add_foreign_key "evaluations", "users"
  add_foreign_key "evaluations", "users", column: "rate_id"
  add_foreign_key "exchangepoints", "users"
  add_foreign_key "exchangepoints", "users", column: "give_id"
  add_foreign_key "exchangepoints", "users", column: "give_issue_id"
  add_foreign_key "exchangepoints", "users", column: "issue_id"
  add_foreign_key "havethings", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "messages", "users", column: "talk_id"
  add_foreign_key "nomalpoints", "users"
  add_foreign_key "nomalpoints", "users", column: "issue_id"
  add_foreign_key "point_confirmations", "messages"
  add_foreign_key "point_confirmations", "users"
  add_foreign_key "point_confirmations", "users", column: "get_issue_id"
  add_foreign_key "point_confirmations", "users", column: "give_id"
  add_foreign_key "point_confirmations", "users", column: "give_issue_id"
  add_foreign_key "wantthings", "users"
end
