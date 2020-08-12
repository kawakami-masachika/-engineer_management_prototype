class ProjectPhase < ApplicationRecord
  # 関連付け
  belongs_to :project
  belongs_to :employee
  belongs_to :mst_phase

  # 論理削除
  acts_as_paranoid
end
