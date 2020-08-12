class Project < ApplicationRecord
  # 関連付け
  has_many :project_phases ,dependent: :destroy
  has_many :adopt_technologies
  has_many :mst_skills, through: :adopt_technologies
  belongs_to :mst_industry

  # 論理削除カラム追加
  acts_as_paranoid
end
