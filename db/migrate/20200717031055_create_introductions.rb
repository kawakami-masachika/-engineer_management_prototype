class CreateIntroductions < ActiveRecord::Migration[5.2]
  def change
    create_table :introductions do |t|
      t.references :employee, index: {unique: true}, foreign_key: true
      t.text :introduction, null: false, limit: 500
    end
  end
end
