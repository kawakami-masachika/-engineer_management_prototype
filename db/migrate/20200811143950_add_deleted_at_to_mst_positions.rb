class AddDeletedAtToMstPositions < ActiveRecord::Migration[5.2]
  def change
    add_column :mst_positions, :deleted_at, :datetime
    add_index :mst_positions, :deleted_at
  end
end
