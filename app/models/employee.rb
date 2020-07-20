class Employee < ApplicationRecord
  has_one :introduction
  has_many :licenses
  has_many :mst_skills, :through => :employee_siklls
end
