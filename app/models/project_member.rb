class ProjectMember < ApplicationRecord
  enum end_flg: { joining: 0, leaved: 1 }
  # 関連付け
  belongs_to :employee
  belongs_to :project
  belongs_to :mst_position

  # バリデーション
    # プロジェクト単位 社員IDの一意制約
    validates :employee_id, uniqueness: { scope: :project_id}
end
