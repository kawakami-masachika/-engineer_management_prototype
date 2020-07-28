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

ActiveRecord::Schema.define(version: 2020_07_27_163115) do

  create_table "employee_seqences", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  end

  create_table "employee_siklls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "mst_skill_id"
    t.integer "sikll_period", null: false
    t.integer "level", null: false
    t.index ["employee_id"], name: "index_employee_siklls_on_employee_id", unique: true
    t.index ["mst_skill_id"], name: "index_employee_siklls_on_mst_skill_id", unique: true
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "employee_id", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "kana_last_name", null: false
    t.string "kana_first_name", null: false
    t.date "birth_date", null: false
    t.string "join_date", limit: 8, null: false
    t.string "experience", null: false
    t.string "line", null: false
    t.string "station", null: false
    t.integer "data_status", default: 1, null: false
    t.string "employee_icon"
    t.bigint "mst_gender_id", null: false
    t.bigint "mst_employee_type_id", null: false
    t.index ["mst_employee_type_id"], name: "index_employees_on_mst_employee_type_id"
    t.index ["mst_gender_id"], name: "index_employees_on_mst_gender_id"
  end

  create_table "introductions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.text "introduction", null: false
    t.index ["employee_id"], name: "index_introductions_on_employee_id", unique: true
  end

  create_table "licenses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "license", null: false
    t.index ["employee_id"], name: "index_licenses_on_employee_id"
  end

  create_table "mst_employee_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "employee_type"
    t.integer "data_status"
  end

  create_table "mst_genders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "gender", limit: 3, null: false
    t.integer "data_status", null: false
  end

  create_table "mst_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "skill_type_code"
    t.string "skill"
    t.integer "data_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "employee_siklls", "employees"
  add_foreign_key "employee_siklls", "mst_skills"
  add_foreign_key "employees", "mst_employee_types"
  add_foreign_key "employees", "mst_genders"
  add_foreign_key "introductions", "employees"
  add_foreign_key "licenses", "employees"
end
