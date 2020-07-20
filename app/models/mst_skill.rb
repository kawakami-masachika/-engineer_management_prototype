class MstSkill < ApplicationRecord
  has_many employees :through => :employee_siklls
end
