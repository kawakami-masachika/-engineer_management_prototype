class Project < ApplicationRecord

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