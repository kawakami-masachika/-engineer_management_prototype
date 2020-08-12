class CreateProjectMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_members do |t|
      t.references :employee, foreign_key: true, null: false
      t.references :project, foreign_key: true, null: false
      t.date :join_date, null: false
      t.date :leave_date
      t.references :mst_position, foreign_key: true, null: false
      t.boolean :end_flg, null: false
    end
  end
end
