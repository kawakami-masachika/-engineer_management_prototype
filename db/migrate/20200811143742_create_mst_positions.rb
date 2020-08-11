class CreateMstPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :mst_positions do |t|
      t.string :position, null: false
    end
  end
end
