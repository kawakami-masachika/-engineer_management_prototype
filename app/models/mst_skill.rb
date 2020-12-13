class MstSkill < ApplicationRecord
  belongs_to :mst_skill_category
  has_many :employee_siklls
  has_many :employees, through: :employee_siklls
  has_many :adopt_technologies
  has_many :mst_skills, through: :adopt_technologies
end