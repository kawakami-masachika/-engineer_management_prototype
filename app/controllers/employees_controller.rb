class EmployeesController < ApplicationController
  def index
    @q = Employee.ransack(params[:q])
    @employees = @q.result
    @q.sorts = 'employee_id asc' if @q.sorts.empty?
    @names = []
    @employees.each do |employee|
      @names << employee.create_full_name(employee.last_name, employee.first_name)
      employee.birth_date = employee.to_age(employee.birth_date)
      employee.join_date = employee.to_date(employee.join_date)
    end
  end
end
