class EmployeesController < ApplicationController
  before_action :require_sign_in!
  before_action :check_admin, only: %w(edit update destroy)
  before_action :current_user, only: %w(edit update)
  before_action :set_employee, only:[:edit, :update, :show, :destroy]

  def index
    # ソート時に再度文字列の分割を防ぐため、チェック
    if !params[:q].nil? && params[:q]["first_name_or_last_name_cont_any"].class == String
      params[:q]["first_name_or_last_name_cont_any"]  = params[:q]["first_name_or_last_name_cont_any"].try{|param| param.split(/[[:blank:]]/)}
    end

    @q = Employee.ransack(params[:q])

    @employees = @q.result.page(params[:page])

    if !params[:q].nil?
      mst_skill_ids = params[:q]["employee_siklls_mst_skill_id"].values
    end

    if !params[:q].nil? && @employees.check_mst_skill_ids_empty(mst_skill_ids)
      if mst_skill_ids.include?("")
        mst_skill_ids = @employees.delete_empty_skills(mst_skill_ids)
      end
      @employees = @employees.have_emoloyee_skills(mst_skill_ids)
    end

    @q.sorts = 'employee_id asc' if @q.sorts.empty?

    @names = []
    @birth_dates = []

    @employees.each do |employee|
      @names << employee.create_full_name(employee.last_name, employee.first_name)
      @birth_dates << employee.to_age(employee.birth_date)
    end
  end

  def edit
    # ログインユーザーと編集対象のユーザーが一致しているか
    unless @employee.id == @current_employee.id
      redirect_to employees_path
    end

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
    params.require(:employee).permit(:employee_id, :last_name, :first_name, :kana_last_name, :kana_first_name, :birth_date, 
                                    :join_date, :experience, :line, :station, :mst_employee_type_id, :mail, :password, :password_confirmation,
                                    :mst_gender_id, [licenses_attributes:[:id, :license, :_destroy]],
                                    [introduction_attributes:[:id,:introduction]],[employee_siklls_attributes:[:id, :employee_id, :mst_skill_id, :sikll_period, :level]])
  end

  def join_date
    birth_date = params[:employee]
    
    unless birth_date["birth_date(1i)"].empty? && birth_date["birth_date(2i)"].empty? && birth_date["birth_date(3i)"].empty?
    end

    return Date.new birth_date["birth_date(1i)"].to_i, birth_date["birth_date(2i)"].to_i, birth_date["birth_date(3i)"].to_i
  end

  def check_admin
    redirect_to employees_path unless @current_employee.admin?
  end
end