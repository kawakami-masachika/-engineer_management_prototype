class ProjectsController < ApplicationController
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
    @project = ProjectRegistrationForm.new(edit_params)
  end

  def update
    @project = ProjectRegistrationForm.new(projects_params)
    @project.employee_id = current_employee.id

    if @project.valid?
      @project.update
      redirect_to employee_path(current_employee.id)
    else
      render action: 'edit'
    end
  end

  def show

  end

  private
  def edit_params
    @employee = Employee.find(params[:employee_id])

    @project = @employee.projects.find(params[:id])
    @project_members  = @project.project_members.where(employee_id: @employee.id)[0]
    @proect_phases = @project.project_phases.where(project_id: @project.id, employee_id: @employee.id)
    @project_adopt_tech = @project.adopt_technologies.where(project_id: @project.id)

    projects_attributes = @project.slice(
      :project_name,
      :mst_industry_id,
      :members,
      :summary
    )

    project_members_attributes = @project_members.slice(
      :mst_position_id,
      :end_flg
    )
    projects_attributes.merge!(project_members_attributes)

    # プロジェクトid
    projects_attributes[:project_id] = @project.id

    # チーム内ポジジョンID
    projects_attributes[:project_members_id] = @project_members.id

    # プロジェクト工程ids
    projects_attributes[:adopt_tech_ids] = @proect_phases.map{|phase| phase[:id]}

    # プロジェクト工程
    projects_attributes[:mst_phase_ids] = @proect_phases.map{|phase|phase[:mst_phase_id]}

    # 採用技術ids
    projects_attributes[:adopt_tech_ids] = @project_adopt_tech.map{|tech|tech[:id]}
    binding.pry

    # 採用技術
    projects_attributes[:mst_skill_ids] = @project_adopt_tech.map{|tech| tech[:mst_skill_id]}
    binding.pry

    return projects_attributes.to_h
  end

  def projects_params
    params.require(:project_registration_form).permit(:project_name, :mst_industry_id, :members, :summary, :employee_id,
                                    :join_date, :leave_date, :mst_position_id, :end_flg, :project_id, :project_members_id, mst_skill_ids: [], adopt_tech_ids: [], mst_phase_ids: [])
  end
end
