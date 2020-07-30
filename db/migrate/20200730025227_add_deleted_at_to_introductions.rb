class AddDeletedAtToIntroductions < ActiveRecord::Migration[5.2]
  def change
    add_column :introductions, :deleted_at, :datetime
    add_index :introductions, :deleted_at
  end
end
