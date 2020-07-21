class Employee < ApplicationRecord
  has_one :introduction
  has_many :licenses
  has_many :mst_skills, :through => :employee_siklls
  belongs_to :mst_gender

  attr_accessor :name, :name_kana

  CONST_HALF_SPACE = " "
  CONST_HALF_SPACE.freeze

  def create_full_name(last_name, first_name)
    binding.pry
    self.name = last_name + CONST_HALF_SPACE + first_name
    return self.name
  end

  def create_full_name_kana(last_name_kana, first_name_kana)
    self.name_kana = last_name_kana + CONST_HALF_SPACE + first_name_kana
  end
end
