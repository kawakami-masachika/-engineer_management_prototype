class AddMstEmployeeTypeToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_reference :employees, :mst_employee_type, foreign_key: true, null: false
  end
end
