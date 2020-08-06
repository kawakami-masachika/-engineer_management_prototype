class EmployeesController < ApplicationController
  before_action :set_employee, only:[:edit, :update, :show, :destroy]
  # before_action :set_skills, only:[:new]
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
    @employee.employee_siklls.build
  end

  def create
    params[:employee][:birth_date] = join_date
    @employee = Employee.new(employees_params)
    if @employee.save 
      redirect_to controller: 'employees', action: 'index'
    else
      render action: 'new'
    end
  end

  def edit
    # 保有が登録されていない場合インスタンスを作成
    if @employee.licenses.empty?
      @employee.licenses.build
    end

    # スキルが登録されていない場合インスタンスを作成
    if @employee.employee_siklls.empty?
      @employee.employee_siklls.build
    end
  end

  def update
    binding.pry
    params[:employee][:birth_date] = join_date
    if @employee.update(employees_params)
      redirect_to controller: 'employees', action: 'index'
    else
      render action: 'edit'
    end
  end

  def show
    @gender = @employee.mst_gender[:gender]
    @employee_type = @employee.mst_employee_type[:employee_type]
    @age = @employee.to_age(@employee.birth_date)
    
  end

  def destroy
    @employee.destroy
    redirect_to controller: 'employees', action: 'index'
  end


  private
  def set_skills
    @mst_skills = MstSkill.all
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employees_params
    params.require(:employee).permit(:employee_id, :last_name, :first_name, :kana_last_name, :kana_first_name, 
                                    :birth_date, :join_date, :experience, :line, :station, :mst_employee_type_id,
                                    :mst_gender_id, [licenses_attributes:[:id, :license, :_destroy]],
                                    [introduction_attributes:[:id,:introduction]],[employee_siklls_attributes:[:id, :employee_id, :mst_skill_id, :sikll_period, :level]])
  end

  def join_date
    birth_date = params[:employee]
    
    unless birth_date["birth_date(1i)"].empty? && birth_date["birth_date(2i)"].empty? && birth_date["birth_date(3i)"].empty?
    end

    return Date.new birth_date["birth_date(1i)"].to_i, birth_date["birth_date(2i)"].to_i, birth_date["birth_date(3i)"].to_i
  end
end
