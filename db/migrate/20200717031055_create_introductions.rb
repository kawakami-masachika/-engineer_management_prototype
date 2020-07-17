class CreateIntroductions < ActiveRecord::Migration[5.2]
  def change
    create_table :introductions do |t|
      t.references :employee, foreign_key: true
      t.text :introduction
    end
  end
end
