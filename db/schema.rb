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

ActiveRecord::Schema.define(version: 2019_11_25_131426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "time_entries", force: :cascade do |t|
    t.date "date", null: false
    t.integer "hours_worked", null: false
    t.string "employee_id", null: false
    t.string "job_group", null: false
    t.bigint "time_report_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["time_report_id"], name: "index_time_entries_on_time_report_id"
  end

  create_table "time_reports", force: :cascade do |t|
    t.string "report_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "time_entries", "time_reports"
end
