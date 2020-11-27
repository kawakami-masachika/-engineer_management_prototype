class ProjectsController < ApplicationController
  CONST_JOIN = "join_date"
  CONST_LEAVE = "leave_date"
  def new
    @project = ProjectRegistrationForm.new
    @employee_id = params[:employee_id].to_i
  end

  def create
    @project = ProjectRegistrationForm.new(projects_params)

    if @project.valid?
      @project.save
      redirect_to employee_path(Employee.find(params[:project_registration_form][:employee_id]))
    else
      render action: 'new'
    end
  end

  def edit
    session[:employee_id] = Employee.find(params[:employee_id])
    @project = ProjectRegistrationForm.new(edit_format)
  end

  def update
    @project = ProjectRegistrationForm.new(projects_params)
    @project.employee_id = session[:employee_id]["id"]

    if @project.valid?
      @project.update
      redirect_to employee_path(session[:employee_id]["id"])
      # セッションクリア
      session[:employee_id]["id"] = nil
    else
      render action: 'edit'
    end
  end

  def show

  end

  private

  def edit_format
    @employee = Employee.find(params[:employee_id])
    @project = @employee.projects.find(params[:id])
    @project_members  = @project.project_members.where(project_id: @project.id)[0]
    @proect_phases = @project.project_phases.where(project_id: @project.id)
    @project_adopt_tech = @project.adopt_technologies.where(project_id: @project.id)

    phase_ids  = @proect_phases.map{|phase| phase[:id]}
    phases = @proect_phases.map{|phase| phase[:mst_phase_id]}
    adopt_tech_ids = @project_adopt_tech.map{|tech| tech[:id]}
    adopt_techs = @project_adopt_tech.map{|tech| tech[:mst_skill_id]}


    projects_attributes = {}
    # プロジェクトID
    projects_attributes[:project_id] = @project.id
    # プロジェクト名
    projects_attributes[:project_name] = @project.project_name
    # 業界
    projects_attributes[:mst_industry_id] = @project.mst_industry_id
    # チームメンバー
    projects_attributes[:members] = @project.members
    # プロジェクト概要
    projects_attributes[:summary] = @project.summary

    # チーム内ポジジョンID
    projects_attributes[:project_members_id] = @project_members.id

    # チーム内ポジション
    projects_attributes[:mst_position_id] = @project_members.mst_position_id

    # プロジェクト参画状態
    projects_attributes[:end_flg] = @project_members.end_flg

    # プロジェクト工程ids
    projects_attributes[:adopt_tech_ids] = phase_ids

    # プロジェクト工程
    projects_attributes[:mst_phase_ids] = phases

    # 採用技術ids
    projects_attributes[:adopt_tech_ids] = adopt_tech_ids

    # 採用技術
    projects_attributes[:mst_skill_ids] = adopt_techs

    return projects_attributes
  end

  def projects_params
    params.require(:project_registration_form).permit(:project_name, :mst_industry_id, :members, :summary, :employee_id,
                                    :join_date, :leave_date, :mst_position_id, :end_flg, :project_id, :project_members_id, mst_phase_ids: [], mst_skill_ids: [],
                                    mst_position_ids: [], adopt_tech_ids: [])
  end
end
