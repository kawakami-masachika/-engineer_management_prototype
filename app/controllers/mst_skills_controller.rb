class MstSkillsController < ActionController::Base
  def index
    mst_skill_category = MstSkillCategory.find(params[:mst_skill_category_id])
    render json: mst_skill_category.mst_skills.select(:id,:skill)
  end
end
