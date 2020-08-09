class CreateMstSkillCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :mst_skill_categories do |t|
      t.string :category
    end
  end
end
