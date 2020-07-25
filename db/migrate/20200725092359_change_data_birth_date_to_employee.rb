class ChangeDataBirthDateToEmployee < ActiveRecord::Migration[5.2]
  def change
    change_column :employees, :birth_date, :date
  end
end
