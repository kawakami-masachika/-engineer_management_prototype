class ChangeDatatypeSkillTypeCodeOfMstSkills < ActiveRecord::Migration[5.2]
  def change
    change_column :mst_skills, :skill_type_code, :integer, limit: 1
  end
end
