class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :employee_id
      t.string :last_name
      t.string :first_name
      t.string :kana_first_name
      t.string :birth_date
      t.string :join_date
      t.string :experience
      t.string :line
      t.string :station
      t.integer :mst_employee_type_id
      t.integer :data_status
      t.string :employee_icon
    end
  end
end
