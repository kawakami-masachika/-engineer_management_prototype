class CreateEmployeeSiklls < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_siklls do |t|
      t.references :employee, foreign_key: true
      t.references :mst_skill, foreign_key: true
      t.integer :sikll_period
      t.integer :level
    end
  end

  add_index :employee_siklls, [:employee_id, :mst_skill_id], unique: true
end
