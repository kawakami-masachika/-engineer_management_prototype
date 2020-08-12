class AdoptTechnology < ApplicationRecord
  # 関連づけ
  belongs_to :project
  belongs_to :mst_skill

  # 論理削除
  acts_as_paranoid

  # プロジェクト単位 採用スキルの一意制約
  validates :mst_skill_id, uniqueness: { scope: :project_id}
end
