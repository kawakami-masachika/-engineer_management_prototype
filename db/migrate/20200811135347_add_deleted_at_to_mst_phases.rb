class AddDeletedAtToMstPhases < ActiveRecord::Migration[5.2]
  def change
    add_column :mst_phases, :deleted_at, :datetime
    add_index :mst_phases, :deleted_at
  end
end
