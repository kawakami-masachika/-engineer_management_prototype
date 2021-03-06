class ApplicationController < ActionController::Base

  before_action :current_employee
  before_action :require_sign_in!


  def current_employee
    remember_token =  Employee.encrypt(cookies[:employee_remember_token])
    @current_employee ||= Employee.find_by(remember_token: remember_token)
  end

  def sign_in(employee)
    remember_token  = Employee.new_remember_token
    cookies.permanent[:employee_remember_token] = remember_token
    employee.update!(remember_token: Employee.encrypt(remember_token))
    @current_employee = employee
  end

  def sign_out
    cookies.delete(:employee_remember_token)
  end

  def signed_in?
    @current_employee.present?
  end

  private
  def require_sign_in!
    redirect_to login_path unless signed_in?
  end


end
