class ChangeDataMembersToProjects < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :members, :string, null: false, limit: 4
  end
end
