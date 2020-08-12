class Project < ApplicationRecord
  # 関連付け
  has_many :project_phases ,dependent: :destroy
  belongs_to :mst_industry

  # 論理削除カラム追加
  acts_as_paranoid
end
