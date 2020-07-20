class AddEmployeeToMstGenders < ActiveRecord::Migration[5.2]
  def change
    add_reference :employees, :mst_gender, null: false, foreign_key: true 
  end
end
