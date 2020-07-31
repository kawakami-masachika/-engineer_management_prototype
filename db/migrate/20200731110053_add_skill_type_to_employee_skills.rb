class AddSkillTypeToEmployeeSkills < ActiveRecord::Migration[5.2]
  def change
    add_column :employee_siklls, :skill_type, :integer, limit: 1
  end
end
