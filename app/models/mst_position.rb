class MstPosition < ApplicationRecord
  # 関連付け
  has_many :project_members
  has_many :project_phases
  has_many :projects , through: :project_phases

  # 論理削除
  acts_as_paranoid
end
