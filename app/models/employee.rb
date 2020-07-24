class Employee < ApplicationRecord
  #関連付け
  has_one :introduction
  has_many :licenses
  has_many :mst_skills, :through => :employee_siklls
  belongs_to :mst_gender
  belongs_to :mst_employee_type
  accepts_nested_attributes_for :licenses, :introduction 

  attr_accessor :name, :name_kana

  # 定数定義
  CONST_HALF_SPACE = " "
  CONST_YEAR = " "
  CONST_HALF_SPACE.freeze

  def create_full_name(last_name, first_name)
    self.name = last_name + CONST_HALF_SPACE + first_name
    return self.name
  end

  def create_full_name_kana(last_name_kana, first_name_kana)
    self.name_kana = last_name_kana + CONST_HALF_SPACE + first_name_kana
  end
  
  def to_age(birth_date)
    return ((Date.today.strftime("%Y%m%d").to_i - birth_date.to_i) / 10000).to_s + AGE
  end

  def to_date(join_date)
    return join_date.slice(0, 4) + DATE::YEAR + join_date.slice(4, 2) + DATE::MONTH + join_date.slice(6, 7) + DATE::DAY
  end
end
