class ChangeDataJoinDateToEmployee < ActiveRecord::Migration[5.2]
  def change
    change_column :employees, :join_date, :date
  end
end
