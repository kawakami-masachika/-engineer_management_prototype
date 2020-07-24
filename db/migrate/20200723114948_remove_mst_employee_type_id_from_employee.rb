class RemoveMstEmployeeTypeIdFromEmployee < ActiveRecord::Migration[5.2]
  def change
    remove_column :employees, :mst_employee_type_id, :integer
  end
end
