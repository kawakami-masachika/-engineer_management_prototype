class AddMstSkillCategoryRefToMstskill < ActiveRecord::Migration[5.2]
  def change
    add_reference :mst_skills, :mst_skill_category, null: false, foreign_key: true
  end
end
