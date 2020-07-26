class EmployeesController < ApplicationController
  def index
    @q = Employee.ransack(params[:q])
    @employees = @q.result
    @q.sorts = 'employee_id asc' if @q.sorts.empty?
    @names = []
    @employees.each do |employee|
      @names << employee.create_full_name(employee.last_name, employee.first_name)
      employee.birth_date = employee.to_age(employee.birth_date)
      # employee.join_date.to_s = employee.to_sting_date(employee.join_date)
    end
  end

  def new
    @employee = Employee.new
    @employee.licenses.build
    @employee.build_introduction
  end

  def create
    params[:employee][:birth_date] = join_date
    @employee = Employee.new(employees_params)
    if @employee.save 
      redirect_to action: index
    else
      render "new"
    end

  end

  def show

  end


  private

  def employees_params
    params.require(:employee).permit(:employee_id, :last_name, :first_name, :kana_last_name, :kana_first_name, 
                                    :birth_date, :join_date, :experience, :line, :station, :mst_employee_type_id,
                                    :mst_gender_id, [license_attributes:[:license]],[introduction_attributes:[:introduction]])
  end

  def join_date
    birth_date = params[:employee]
    
    unless birth_date["birth_date(1i)"].empty? && birth_date["birth_date(2i)"].empty? && birth_date["birth_date(3i)"].empty?
      # birth_date = padding_date(birth_date)
    end

    return Date.new birth_date["birth_date(1i)"].to_i, birth_date["birth_date(2i)"].to_i, birth_date["birth_date(3i)"].to_i
  end
end
