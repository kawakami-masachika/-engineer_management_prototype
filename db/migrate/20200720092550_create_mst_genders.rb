class CreateMstGenders < ActiveRecord::Migration[5.2]
  def change
    create_table :mst_genders do |t|
      t.string :gender, limit: 3,  null: false
      t.integer :data_status, null: false
    end
  end
end
