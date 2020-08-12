class AdoptTechnology < ApplicationRecord
  belongs_to :project
  belongs_to :mst_skill

  # プロジェクト単位 採用スキルの一意制約
  validates :mst_skill_id, uniqueness: { scope: :project_id}
end
