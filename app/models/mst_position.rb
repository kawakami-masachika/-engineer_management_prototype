class MstPosition < ApplicationRecord
  # 関連付け
  has_many :project_members

  # 論理削除
  acts_as_paranoid
end
