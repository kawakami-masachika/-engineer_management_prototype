class RemoveAgeFromEmployee < ActiveRecord::Migration[5.2]
  def change
    remove_column :employees, :age, :integer
  end
end
