class CreateMstPhases < ActiveRecord::Migration[5.2]
  def change
    create_table :mst_phases do |t|
      t.string :phase, null: false
    end
  end
end
