class Employee < ApplicationRecord
  #関連付け
  has_one :introduction
  has_many :licenses
  has_many :mst_skills, :through => :employee_siklls
  belongs_to :mst_gender
  belongs_to :mst_employee_type
  accepts_nested_attributes_for :licenses, :introduction
  # バリデーション
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :kana_last_name, presence: true
  validates :kana_first_name, presence: true
  validates :birth_date, presence: true
  validates :join_date, presence: true
  validates :experience, presence: true
  validates :line, presence: true
  validates :station, presence: true
  validates :mst_employee_type_id, presence: true
  validates :mst_gender_id, presence: true


  attr_accessor :name, :name_kana

  # 定数定義
  CONST_HALF_SPACE = " "
  CONST_HALF_SPACE.freeze

  CONST_ZERO = "0"
  CONST_ZERO.freeze

  CONST_HYPHEN = "-"
  CONST_HYPHEN.freeze

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

  def join_date(**params)
    birth_date = params[:employee][:birth_date]
    
    unless birth_date["birthday(1i)"].empty? && birth_date["birthday(2i)"].empty? && birth_date["birthday(3i)"].empty?

    end

    return birth_date["birthday(1i)"] + birth_date["birthday(2i)"] + birth_date["birthday(3i)"]


  end

  def padding_date(date)

    if date["birthday(2i)"].length == 1
      date["birthday(2i)"] =  CONST_ZERO + date["birthday(2i)"]
    end

    if date["birthday(3i)"].length == 1
      date["birthday(3i)"] =  CONST_ZERO + date["birthday(3i)"]
    end

  end

  def valid_date(date)
    tmp_date = date["birthday(1i)"] + date["birthday(2i)"] + date["birthday(3i)"]
    y, m ,d = tmp_date.split(CONST_HYPHEN).map(&:to_i)
    Date.valid_date?(y, m, d)
  end

end
