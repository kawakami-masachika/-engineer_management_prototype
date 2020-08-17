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

ActiveRecord::Schema.define(version: 2020_08_17_015009) do

  create_table "adopt_technologies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "mst_skill_id", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_adopt_technologies_on_deleted_at"
    t.index ["mst_skill_id"], name: "index_adopt_technologies_on_mst_skill_id"
    t.index ["project_id"], name: "index_adopt_technologies_on_project_id"
  end

  create_table "employee_seqences", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  end

  create_table "employee_siklls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "mst_skill_id"
    t.integer "sikll_period", null: false
    t.integer "level", null: false
    t.index ["employee_id"], name: "index_employee_siklls_on_employee_id"
    t.index ["mst_skill_id"], name: "index_employee_siklls_on_mst_skill_id"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "employee_id", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "kana_last_name", null: false
    t.string "kana_first_name", null: false
    t.date "birth_date", null: false
    t.date "join_date", null: false
    t.string "experience", null: false
    t.string "line", null: false
    t.string "station", null: false
    t.integer "data_status", default: 1, null: false
    t.string "employee_icon"
    t.bigint "mst_gender_id", null: false
    t.bigint "mst_employee_type_id", null: false
    t.datetime "deleted_at"
    t.string "mail", limit: 100, null: false
    t.string "password_digest", limit: 300, null: false
    t.string "remember_token"
    t.boolean "admin", default: false
    t.index ["deleted_at"], name: "index_employees_on_deleted_at"
    t.index ["mst_employee_type_id"], name: "index_employees_on_mst_employee_type_id"
    t.index ["mst_gender_id"], name: "index_employees_on_mst_gender_id"
  end

  create_table "introductions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.text "introduction", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_introductions_on_deleted_at"
    t.index ["employee_id"], name: "index_introductions_on_employee_id", unique: true
  end

  create_table "licenses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "license", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_licenses_on_deleted_at"
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

  create_table "mst_industries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "industry", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_mst_industries_on_deleted_at"
  end

  create_table "mst_phases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "phase", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_mst_phases_on_deleted_at"
  end

  create_table "mst_positions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "position", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_mst_positions_on_deleted_at"
  end

  create_table "mst_skill_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category"
  end

  create_table "mst_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "skill"
    t.bigint "mst_skill_category_id", null: false
    t.index ["mst_skill_category_id"], name: "index_mst_skills_on_mst_skill_category_id"
  end

  create_table "project_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "project_id", null: false
    t.date "join_date", null: false
    t.date "leave_date"
    t.bigint "mst_position_id", null: false
    t.boolean "end_flg", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_project_members_on_deleted_at"
    t.index ["employee_id"], name: "index_project_members_on_employee_id"
    t.index ["mst_position_id"], name: "index_project_members_on_mst_position_id"
    t.index ["project_id"], name: "index_project_members_on_project_id"
  end

  create_table "project_phases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "employee_id"
    t.bigint "mst_phase_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_project_phases_on_deleted_at"
    t.index ["employee_id"], name: "index_project_phases_on_employee_id"
    t.index ["mst_phase_id"], name: "index_project_phases_on_mst_phase_id"
    t.index ["project_id"], name: "index_project_phases_on_project_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "project_name", limit: 50, null: false
    t.bigint "mst_industry_id"
    t.integer "members", limit: 1, null: false
    t.text "summary", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_projects_on_deleted_at"
    t.index ["mst_industry_id"], name: "index_projects_on_mst_industry_id"
  end

  add_foreign_key "adopt_technologies", "mst_skills"
  add_foreign_key "adopt_technologies", "projects"
  add_foreign_key "employee_siklls", "employees"
  add_foreign_key "employee_siklls", "mst_skills"
  add_foreign_key "employees", "mst_employee_types"
  add_foreign_key "employees", "mst_genders"
  add_foreign_key "introductions", "employees"
  add_foreign_key "licenses", "employees"
  add_foreign_key "mst_skills", "mst_skill_categories"
  add_foreign_key "project_members", "employees"
  add_foreign_key "project_members", "mst_positions"
  add_foreign_key "project_members", "projects"
  add_foreign_key "project_phases", "employees"
  add_foreign_key "project_phases", "mst_phases"
  add_foreign_key "project_phases", "projects"
  add_foreign_key "projects", "mst_industries"
end
