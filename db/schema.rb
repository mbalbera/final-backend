# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_06_201425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.string "category"
    t.string "line"
    t.string "text"
    t.string "time"
    t.string "status"
    t.string "kind_of_bet"
    t.integer "over_home_value"
    t.integer "under_away_value"
    t.string "home_team_abr"
    t.string "away_team_abr"
    t.string "home_team_name"
    t.string "away_team_name"
    t.string "home_team_spread"
    t.string "away_team_spread"
    t.integer "event_id"
  end

  create_table "user_bets", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "bet_id"
    t.integer "risk_amt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bet_id"], name: "index_user_bets_on_bet_id"
    t.index ["user_id"], name: "index_user_bets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "availableFunds"
    t.integer "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
