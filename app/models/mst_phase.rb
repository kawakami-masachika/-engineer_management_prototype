class MstPhase < ApplicationRecord
  # 関連付け
  has_many :project_phases
  # 論理削除
  acts_as_paranoid
end
