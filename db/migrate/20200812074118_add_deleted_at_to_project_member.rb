class AddDeletedAtToProjectMember < ActiveRecord::Migration[5.2]
  def change
    add_column :project_members, :deleted_at, :datetime
    add_index :project_members, :deleted_at
  end
end
