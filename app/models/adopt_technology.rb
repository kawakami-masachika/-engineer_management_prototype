class AdoptTechnology < ApplicationRecord
  # 関連づけ
  belongs_to :project
  belongs_to :mst_skill

  # 論理削除
  acts_as_paranoid
end
