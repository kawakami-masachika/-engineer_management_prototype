class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_employee, only: [:create]
  def new
  end

  def create
    if @employee.authenticate(seesion_params[:password])
      sign_in(@employee)
      if @employee.admin?
        redirect_to employee_admin_employees_path(@employee.id)
      else 
        redirect_to employees_path
      end
    else
      flash.now[:danger] = t('.flash.invalid_password')
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

  def set_employee
    @employee = Employee.find_by!(mail: seesion_params[:mail])
  end

  def seesion_params
    params.permit(:mail, :password)
  end
end
