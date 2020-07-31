class RemoveColumnsInMstSkills < ActiveRecord::Migration[5.2]
  def change
    remove_column :mst_skills, :data_status, :integer
    remove_column :mst_skills, :created_at, :datetime
    remove_column :mst_skills, :updated_at, :datetime
  end
end
