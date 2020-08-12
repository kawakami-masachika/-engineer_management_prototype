class AddDeletedAtToProjectPhase < ActiveRecord::Migration[5.2]
  def change
    add_column :project_phases, :deleted_at, :datetime
    add_index :project_phases, :deleted_at
  end
end
