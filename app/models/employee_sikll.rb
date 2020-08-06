class EmployeeSikll < ApplicationRecord

  enum sikll_period: {less_one_year:1, less_three_year:2, less_five_year: 3, over_five_year:4, over_ten_year: 5}
  # 関連付け
  belongs_to :employee
  belongs_to :mst_skill, optional: true

  # バリデーション
  validate :check_blank? 
  with_options unless: :check_blank? do
    validates :mst_skill_id, presence: true
    validates :sikll_period, presence: true
    validates :level, presence: true
  end

  def check_blank?
      attributes["mst_skill_id"].blank? && attributes["sikll_period"].blank? && attributes["level"].blank?
  end

  validates :mst_skill_id, uniqueness: { scope: :employee_id }, on: :update
  validates_uniqueness_of :mst_skill_id, scope: :employee_id, on: :update
end
