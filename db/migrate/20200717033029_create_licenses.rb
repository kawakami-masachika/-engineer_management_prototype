class CreateLicenses < ActiveRecord::Migration[5.2]
  def change
    create_table :licenses do |t|
      t.references :employee, foreign_key: true
      t.string :license, null: false
    end
  end
end
