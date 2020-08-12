class MstIndustry < ApplicationRecord
  # 関連付け
  has_many :projects

  # 論理削除カラム追加
  acts_as_paranoid
end
