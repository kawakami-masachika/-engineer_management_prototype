class EmployeeSikllsController < ApplicationController
  def new
    set_skills
    @employee_id = params[:employee_id].to_i
    @employee_sikll = EmployeeSikll.new(employee_id: params[:employee_id])
  end

  def create
    attributes = []
    attributes = employee_skill_params
    binding.pry
    check_params(attributes)

    attributes.length.times do|index|
        @employee_sikll = EmployeeSikll.new(
                            employee_id: attributes[index]['employee_id'],
                            mst_skill_id: attributes[index]['mst_skill_id'],
                            sikll_period: attributes[index]["sikll_period"],
                            level: attributes[index]["level"]
                          )
                          binding.pry
        if @employee_sikll.save
          if index + 1 == attributes.length
            redirect_to controller: 'employees', action: 'index'
          end
        else
          set_skills
          @employee_sikll
          render action: 'new'
          break

        end
        

    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end


  private

  def set_skills
    @mst_skills = MstSkill.all
    @os = @mst_skills.select{|skill| skill.read_attribute_before_type_cast(:skill_type_code) == 1}
    @f_language = @mst_skills.select{|skill| skill.read_attribute_before_type_cast(:skill_type_code) == 2}
    @ss_language = @mst_skills.select{|skill| skill.read_attribute_before_type_cast(:skill_type_code) == 3}
    @db = @mst_skills.select{|skill| skill.read_attribute_before_type_cast(:skill_type_code) == 4}
    @fw = @mst_skills.select{|skill| skill.read_attribute_before_type_cast(:skill_type_code) == 5}
  end

  def employee_skill_params
    params.require(:employee_sikll)
    unless params[:employee_sikll].nil?
      params.delete(:employee_id)
    end
    params[:employee_sikll].keys.sort.map{|index|params[:employee_sikll][index]}
  end

  def check_params(attributes)
    attributes.delete_if{|attribute| attribute["sikll_period"] == "empty_year"}
  end
end
