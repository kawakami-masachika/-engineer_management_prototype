class EmployeesController < ApplicationController
  def index
    @q = Employee.ransack(params[:q])
    @employees = @q.result
    @q.sorts = 'employee_id asc' if @q.sorts.empty?
    binding.pry
    @names = []
    @employees.each do |employee|
      @names << employee.create_full_name(employee.last_name, employee.first_name)
      employee.birth_date = employee.to_age(employee.birth_date)
      employee.join_date = employee.to_date(employee.join_date)
    end
  end

  def new
    @employee = Employee.new
    @employee.licenses.build
    @employee.build_introduction
  end

  def create
    @employee = Employee.new(employees_params)
    @employee.save 
  end

  def show
  end


  private
  def employees_params
    params.require(:employee).permit(:employee_id, :last_name, :first_name, :kana_last_name, :kana_first_name, 
                                    :birth_date, :join_date, :experience, :line, :station, :mst_employee_type_id,
                                    :mst_gender_id, [license_attributes:[:license]],[introduction_attributes:[:introduction]])
  end
end
