class CreateMstSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :mst_skills do |t|
      t.string :skill_type_code
      t.string :skill
      t.integer :data_status

      t.timestamps
    end
  end
end
