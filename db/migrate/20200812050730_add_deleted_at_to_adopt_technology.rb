class AddDeletedAtToAdoptTechnology < ActiveRecord::Migration[5.2]
  def change
    add_column :adopt_technologies, :deleted_at, :datetime
    add_index :adopt_technologies, :deleted_at
  end
end
