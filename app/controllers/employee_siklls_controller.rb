class EmployeeSikllsController < ApplicationController
  def new
    @employee_id = params[:id].to_i
    @employee_sikll = EmployeeSikll.new
  end

  def create
    @employee_skill = EmployeeSkill.new(employee_skill_params)
  end


  private
  def employee_skill_params
    params.reqire(:employee_skill).permit(:mst_skill_id, :sikll_period, :level)
  end
end
