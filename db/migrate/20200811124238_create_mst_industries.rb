class CreateMstIndustries < ActiveRecord::Migration[5.2]
  def change
    create_table :mst_industries do |t|
      t.string :industry, null: false
    end
  end
end
