class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :project_name, null: false, limit: 50
      t.references :mst_industry, foreign_key: true
      t.integer :members, null: false, limit: 1
      t.text :summary, null: false, limit: 500
    end
  end
end
