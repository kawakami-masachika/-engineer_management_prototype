class CreateAdoptTechnologies < ActiveRecord::Migration[5.2]
  def change
    create_table :adopt_technologies do |t|
      t.references :project, foreign_key: true, null: false
      t.references :mst_skill, foreign_key: true, null: false
    end
  end
end
