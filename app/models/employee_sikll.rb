class EmployeeSikll < ApplicationRecord
  validates :sikll_period, presence: true
  validates :level, presence: true
  belongs_to :employee
  belongs_to :mst_skill

  enum sikll_period: {empty_year:0, less_one_year:1, less_three_year:2, less_five_year: 3, over_five_year:4, over_ten_year: 5}

  
end
