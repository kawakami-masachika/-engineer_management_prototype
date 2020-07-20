class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :employee_id, null: false, unique: true
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :kana_last_name, null: false
      t.string :kana_first_name, null: false
      t.string :birth_date, null: false, limit: 8
      t.string :join_date, null: false, limit: 8
      t.string :experience, null: false
      t.string :line, null: false
      t.string :station, null: false
      t.integer :mst_employee_type_id, null: false, limit: 1
      t.integer :data_status, null: false, default: 1
      t.string :employee_icon
    end
  end
end
