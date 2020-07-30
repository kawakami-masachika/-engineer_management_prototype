class AddDeletedAtToLicenses < ActiveRecord::Migration[5.2]
  def change
    add_column :licenses, :deleted_at, :datetime
    add_index :licenses, :deleted_at
  end
end
