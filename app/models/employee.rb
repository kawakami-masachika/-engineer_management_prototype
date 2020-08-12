class Employee < ApplicationRecord
  # コールバック
  before_validation :set_employee_id, :trim
  # before_validation :check_empty_skills
  before_save :check_empty_skills

  # 論理削除
  acts_as_paranoid

  #関連付け
  has_one :introduction, dependent: :destroy
  has_many :licenses, dependent: :destroy
  has_many :employee_siklls
  has_many :mst_skills, through: :employee_siklls
  has_many :project_members, dependent: :destroy
  has_many :projects, through: :project_members
  has_many :project_phases, dependent: :destroy
  belongs_to :mst_gender
  belongs_to :mst_employee_type
  accepts_nested_attributes_for :licenses, allow_destroy: true
  accepts_nested_attributes_for :introduction
  accepts_nested_attributes_for :employee_siklls, allow_destroy: true

  # バリデーション
  validates :employee_id, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :kana_last_name, presence: true
  validates :kana_first_name, presence: true
  validates :birth_date, presence: true
  validates :join_date, presence: true
  # validates :experience, presence: true
  validates :line, presence: true
  validates :station, presence: true
  validates :mst_employee_type_id, presence: true
  validates :mst_gender_id, presence: true
  
  #自作バリデーション
  validate :check_empty_licenses
  validate :license_unique?
  validate :check_empty_skills
  validate :skill_unique?

  validates_associated :employee_siklls

  #社員スキル 登録時に空の場合はレコードを削除する
  def check_empty_skills
    self.employee_siklls.each do |skill|
      skill.mark_for_destruction if skill[:mst_skill_id].blank? && skill[:sikll_period].blank? && skill[:level].blank?
    end
  end

  #保有資格 登録・編集時に空の場合はレコードを削除する
  def check_empty_licenses
    self.licenses.each do |license|  
      license.mark_for_destruction if license[:license].blank?
    end
  end

  #ページネーション デフォルト件数
  paginates_per 20

  attr_accessor :name, :name_kana

  # 定数定義
  CONST_HALF_SPACE = " "
  CONST_HALF_SPACE.freeze

  CONST_ZERO = "0"
  CONST_ZERO.freeze

  CONST_HYPHEN = "-"
  CONST_HYPHEN.freeze

  CONST_EMPLOYEE_IDENTIFIER = "ST"
  CONST_EMPLOYEE_IDENTIFIER.freeze

  def create_full_name(last_name, first_name)
    self.name = last_name + CONST_HALF_SPACE + first_name
    return self.name
  end

  def create_full_name_kana(last_name_kana, first_name_kana)
    self.name_kana = last_name_kana + CONST_HALF_SPACE + first_name_kana
  end
  
  def to_age(birth_date)
    return ((Date.today.strftime("%Y%m%d").to_i - birth_date.strftime("%Y%m%d").to_i) / 10000).to_s + AGE
  end

  def valid_date(date)
    tmp_date = date["birthday(1i)"] + date["birthday(2i)"] + date["birthday(3i)"]
    y, m ,d = tmp_date.split(CONST_HYPHEN).map(&:to_i)
    Date.valid_date?(y, m, d)
  end

  def set_employee_id
    # 社員番号の空をチェック
    if self.employee_id.blank?
      ActiveRecord::Base.uncached do
        # シーケンスのインクリメント
        EmployeeSeqence.connection.execute('UPDATE employee_seqences SET id = LAST_INSERT_ID(id+1)')
        employee_id = EmployeeSeqence.find_by_sql('SELECT SQL_NO_CACHE LAST_INSERT_ID() AS id').first
        padding_employee_id(employee_id)
      end
    end
  end

  def padding_employee_id(employee_id)
    seqence = employee_id[:id]
    length = employee_id[:id].to_s.length

    case length
    when 1 then
      self.employee_id = CONST_EMPLOYEE_IDENTIFIER + format('%04d', seqence)
    when 2 then
      self.employee_id = CONST_EMPLOYEE_IDENTIFIER + format('%04d', seqence)
    when 3 then
      self.employee_id = CONST_EMPLOYEE_IDENTIFIER + format('%04d', seqence)
    when 4 then
      self.employee_id = CONST_EMPLOYEE_IDENTIFIER + seqence
    else
      #例外を考慮する
    end
  end
  
  scope :have_emoloyee_skills, -> (mst_skills){
    mst_skills.map{|mst_skill_id|mst_skill_id.to_i}
    joins(:employee_siklls).merge(EmployeeSikll.where(mst_skill_id: mst_skills)).distinct
  }

  # 検索時 社員スキルパラメータチェック
  def self.check_mst_skill_ids_empty(mst_skill_ids)
    mst_skill_ids = mst_skill_ids.select{|skill_id| skill_id != ""}
    if mst_skill_ids.length > 0
      return true
    else
      return false
    end
  end

  def self.delete_empty_skills(mst_skill_ids)
    return mst_skill_ids.delete_if{|skill_id| skill_id.empty?}
  end

  private

  def trim
    licenses.select{|i| 
      i[:license].sub!(/\s+/, "")
      i[:license].sub!(/\s+$/, "")
    }
  end

  def license_unique?
      license = licenses.map{|l| l[:license]}
      license.delete_if(&:empty?)

      if license.length > 0
        if license.length != license.uniq.length 
          errors.add(:licenses, "が重複しています")
        end
      end
  end

  def skill_unique?
    skills = []

    employee_siklls.each do |skill|
      if skill[:mst_skill_id].blank? && skill[:sikll_period].blank? && skill[:level].blank? 
        next 
      else 
        skills << skill[:mst_skill_id]
      end
    end

    binding.pry
    if skills.length > 0
      if skills.length != skills.uniq.length 
        errors.add(:skills, "が重複しています")
      end
    end
  end

end
