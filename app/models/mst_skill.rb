class MstSkill < ApplicationRecord
  has_many :employee_siklls
  has_many :employees, through: :employee_siklls
  enum skill_type_code: {OS: 1, フロント言語: 2, サーバーサイド言語: 3, データベース: 4, フレームワーク: 5}
end
