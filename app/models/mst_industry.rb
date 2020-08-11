class MstIndustry < ApplicationRecord
  # 論理削除カラム追加
  acts_as_paranoid
end
