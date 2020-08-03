class CreateEmployeeSiklls < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_siklls do |t|
      t.references :employee,  foreign_key: true
      t.references :mst_skill, foreign_key: true
      t.integer :sikll_period, null: false
      t.integer :level, null: false
    end
  end
end
