class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
    @names = []
    @employees.each do |employee|
      @names << employee.create_full_name(employee.last_name, employee.first_name)
    end
  end
end
