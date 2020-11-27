class Project < ApplicationRecord
  attr_accessor :validate_flg, :join_date, :leave_date

  validate_flg = false
  VALIDATE_MEMBERS_FORMAT = /\A[0-9]+\z/
  JOIN_FLG = 0
  LEAVE_FLG = 1
  CONST_JOIN_DATE = "join_date"
  CONST_LEAVE_DATE = "leave_date"

  #モデル アソシエーション
  has_many :employees, through: :project_members
  has_many :project_members, dependent: :destroy
  has_many :project_phases, dependent: :destroy
  has_many :mst_phases, through: :project_phases
  has_many :adopt_technologies, dependent: :destroy
  has_many :mst_skills, through: :adopt_technologies

  belongs_to :mst_industry

  # 論理削除カラム追加
  acts_as_paranoid
end