class AddColumnsToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :mail, :string, limit: 100, null: false
    add_column :employees, :password_digest, :string, limit: 30, null: false
    add_column :employees, :remember_token, :string
    add_column :employees, :admin, :boolean, default: false
  end
end
