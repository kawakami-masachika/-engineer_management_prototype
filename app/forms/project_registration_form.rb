class ProjectRegistrationForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveRecord::AttributeAssignment

  CONST_BLANK = ""
  VALIDATE_MEMBERS_FORMAT = /\A[0-9]+\z/

  attr_accessor :project_name,
                :mst_industry_id,
                :members, 
                :summary,
                :join_date,
                :leave_date,
                :mst_phase_ids,
                :employee_id,
                :mst_position_id,
                :end_flg,
                :mst_skill_ids,
                :project_id,
                :project_members_id,
                :adopt_tech_ids


  validates :project_name, presence: true

  validates :mst_industry_id, presence: true

  validates :members, presence: true

  validates :summary, presence: true

  validate :selected_mst_phase?

  validates :join_date, presence: true
  validates :join_date, date: true, if: Proc.new{|p|p.join_date.present?}
  validates :join_date, date_format: true, if: Proc.new{|p|p.join_date.present? && p.join_date[1].present? && p.join_date[2].present? && p.join_date[3].present?}

  validates :leave_date, presence: true
  validates :leave_date, date: true, if: Proc.new{|p|p.leave_date.present?}
  validates :leave_date, date_format: true, if: Proc.new{|p|p.join_date.present? && p.leave_date[1].present? && p.leave_date[2].present? && p.leave_date[3].present?}
  validates_with DateCorrelationValidator, attributes: [:join_date, :leave_date]

  validates :mst_position_id, presence: true
  validates :end_flg, presence: true

  validates :project_name, length: {maximum: 50}, allow_blank: true

  validates :members, format: { with: VALIDATE_MEMBERS_FORMAT, message: "は数値のみ入力可能です。"}, allow_blank: true
  validates :members, length: {maximum: 4}, allow_blank: true

  validates :summary, length: {maximum: 500}, allow_blank: true

  # 採用技術
  validate :selected_mst_skill?

  # プロジェクト単位 採用スキルの一意制約
  # validates :mst_skill_ids, uniqueness: { scope: :project_id}



  # validates :employee_id, presence: true

  def uniqeless_tech?(project_id ,mst_skill_id)
    adopot_tech_list = AdoptTechnology.where(project_id: project_id, mst_skill_id: mst_skill_id)
    if adopot_tech_list.length == 0
      return true
    else
      return true
    end
  end

  def selected_mst_phase?
    if mst_phase_ids.blank?
      binding.pry
      errors.add(:mst_phase_ids, "を最低1つ選択して下さい")
    end
  end

  def  selected_mst_skill?
    if mst_skill_ids.blank?
      errors.add(:mst_skill_ids, "を最低1つ選択して下さい")
    end
  end

  def save
    return false if invalid?

    project
    true
  end

  def edit
    @project
  end

  def update
    return false if invalid?
    
    # 更新
    project_update
    true
  end

  private 

  def project
    @project ||= Project.new(project_name: project_name, mst_industry_id: mst_industry_id, members: members, summary: summary)
    @project.save!
    project_members(@project)
    project_phase(@project)
    adopt_technology(@project)
  end

  def project_members(project)
    @project_members ||= ProjectMember.new( employee_id: employee_id, project_id: project.id, join_date: join_date, 
                                            leave_date: leave_date, mst_position_id: mst_position_id, end_flg: end_flg)
    @project_members.save!                                            
  end

  def project_phase(project)
    mst_phase_ids.each do |mst_phase_id|
      @project_phase ||= ProjectPhase.new( employee_id: employee_id, project_id: project.id, mst_phase_id: mst_phase_id)
      @project_phase.save!
    end
  end

  def adopt_technology(project)
    mst_skill_ids.each do |skill_id|
      if(uniqeless_tech?(project.id, skill_id))
        @adopt_technology = AdoptTechnology.new(project_id: project.id, mst_skill_id: skill_id)
        @adopt_technology.save!
      end
    end
  end
  # UPDATE method----------------------------------------------------------------------------------------------------------------------------------------------------------------------
  def project_update
    @project = Project.find(project_id)
    project_atrributes = {}
    project_atrributes[:id] = project_id
    project_atrributes[:project_name] = project_name
    project_atrributes[:mst_industry_id] = mst_industry_id
    project_atrributes[:members] = members
    project_atrributes[:summary] = summary

    @project.update!(project_atrributes)
    project_members_update(@project)
    project_phase_update(@project)
    # adopt_technology_update(@project)
  end

  def project_members_update(project)
    @project_member = project.project_members.find(project_members_id)
    
    pj_members_attributes = {}
    pj_members_attributes[:employee_id] = employee_id
    pj_members_attributes[:project_id] = project_id
    pj_members_attributes[:join_date] = join_date
    pj_members_attributes[:leave_date] = leave_date
    pj_members_attributes[:mst_position_id] = mst_position_id
    pj_members_attributes[:end_flg] =  end_flg
    @project_member.update!(pj_members_attributes)                                    
  end

  def project_phase_update(project)

    @project_phase = project.project_phases.where(project_id: project_id, employee_id: employee_id).order(id: "ASC")
    
    pp_ids  = @project_phase.map{|pp| pp[:mst_phase_id].to_s}

    if pp_ids == mst_phase_ids
      return
    end 
    uniq_phase_ids = pp_ids & mst_phase_ids

    @project_phase.each do |project_phase|
      if !uniq_phase_ids.include?(project_phase[:mst_phase_id].to_s)
        project_phase.destroy!
      end
    end

    # 追加登録するID抽出
    phase_ids = mst_phase_ids.select{|phase_id|!uniq_phase_ids.include?(phase_id)}

    if phase_ids != nil && phase_ids.length >0
      phase_ids.each do |phase_id|
        @project_phase = ProjectPhase.new(employee_id: employee_id, project_id: project.id, mst_phase_id: phase_id)
        @project_phase.save!
      end
    end

  end

  def adopt_technology_update(project)
    mst_skill_ids.each_with_index do |skill_id, index|
      if(uniqeless_tech?(project.id, skill_id))
        @adopt_technology = AdoptTechnology.new(id: adopt_tech_ids[index], project_id: project.id, mst_skill_id: skill_id)
        @adopt_technology.update!
      end
    end
  end
end