class EmployeesController < ApplicationController
  def index
    @q = Employee.ransack(params[:q])
    @employees = @q.result.page(params[:page])
    @q.sorts = 'employee_id asc' if @q.sorts.empty?

    @names = []
    @birth_dates = []

    @employees.each do |employee|
      @names << employee.create_full_name(employee.last_name, employee.first_name)
      @birth_dates << employee.to_age(employee.birth_date)
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
    binding.pry
    if @employee.save 
      redirect_to controller: 'employees', action: 'index'
    else
      binding.pry
      render action: 'new'
    end

  end

  def show

  end


  private

  def employees_params
    params.require(:employee).permit(:employee_id, :last_name, :first_name, :kana_last_name, :kana_first_name, 
                                    :birth_date, :join_date, :experience, :line, :station, :mst_employee_type_id,
                                    :mst_gender_id, [licenses_attributes:[:license]],[introduction_attributes:[:introduction]])
  end

  def join_date
    birth_date = params[:employee]
    
    unless birth_date["birth_date(1i)"].empty? && birth_date["birth_date(2i)"].empty? && birth_date["birth_date(3i)"].empty?
      # birth_date = padding_date(birth_date)
    end

    return Date.new birth_date["birth_date(1i)"].to_i, birth_date["birth_date(2i)"].to_i, birth_date["birth_date(3i)"].to_i
  end
end
