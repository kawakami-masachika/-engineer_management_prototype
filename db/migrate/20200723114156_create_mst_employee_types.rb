class CreateMstEmployeeTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :mst_employee_types do |t|
      t.string :employee_type
      t.integer :data_status
    end
  end
end
