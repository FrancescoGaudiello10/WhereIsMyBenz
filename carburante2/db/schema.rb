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

ActiveRecord::Schema.define(version: 2018_04_29_082459) do

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.integer "stars"
    t.integer "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_comments_on_station_id"
  end

  create_table "implants", primary_key: "idImpianto", id: :text, force: :cascade do |t|
    t.text "Gestore"
    t.text "Bandiera"
    t.text "TipoImpianto"
    t.text "NomeImpianto"
    t.text "Indirizzo"
    t.text "Comune"
    t.text "Provincia"
    t.float "latitude"
    t.float "longitude"
    t.float "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idImpianto"], name: "sqlite_autoindex_implants_1", unique: true
  end

  create_table "prices", id: false, force: :cascade do |t|
    t.text "idImpianto", null: false
    t.text "descCarburante"
    t.text "prezzo"
    t.text "isSelf"
    t.text "dtComu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string "Bandiera"
    t.string "Nome"
    t.string "Indirizzo"
    t.float "Benzina"
    t.float "Diesel"
    t.float "Super"
    t.float "Excellium"
    t.float "Metano"
    t.float "GPL"
    t.boolean "allDay"
    t.boolean "Self"
    t.boolean "autoLavaggio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.boolean "admin", default: false
    t.text "idImpianto"
    t.string "luogo_preferito"
    t.string "stazione_preferita"
    t.string "carburante_preferito"
    t.integer "litri_serbatoio"
    t.string "targa"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
