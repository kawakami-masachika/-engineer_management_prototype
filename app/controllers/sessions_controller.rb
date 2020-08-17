class SessionsController < ApplicationController
  # skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_employee, only: [:create]
  def new
  end

  def create
    binding.pry
    if @employee.authenticate(seesion_params[:password])
      sign_in(@employee)
      redirect_to root_path
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
    binding.pry
    @employee = Employee.find_by(mail: seesion_params[:mail])
  end

  def seesion_params
    params.permit(:mail, :password)
  end
end
