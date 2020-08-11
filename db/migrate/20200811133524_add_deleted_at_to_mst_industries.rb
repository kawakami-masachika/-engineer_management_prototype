class AddDeletedAtToMstIndustries < ActiveRecord::Migration[5.2]
  def change
    add_column :mst_industries, :deleted_at, :datetime
    add_index :mst_industries, :deleted_at
  end
end
