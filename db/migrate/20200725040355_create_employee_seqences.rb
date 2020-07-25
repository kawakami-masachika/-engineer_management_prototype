class CreateEmployeeSeqences < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_seqences, id: false do |t|
      t.column :id, 'int(10) PRIMARY KEY'
    end
  end
end
