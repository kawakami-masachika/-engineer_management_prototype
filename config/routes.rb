Rails.application.routes.draw do
  # get 'employee_skill/new'
  resources :employees do
    resources :employee_siklls
  end
  resources :mst_skill_categories, only: [] do
    resources :mst_skills, only: :index
  end

end
