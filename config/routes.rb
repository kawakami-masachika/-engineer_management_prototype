Rails.application.routes.draw do
  root to: 'employees#index'

  resources :employees do
    resources :projects, except: %w(destroy)
    resources :employee_siklls
  end

  resources :projects, only: %w(index show)

  resources :mst_skill_categories, only: [] do
    resources :mst_skills, only: %w(index)
  end

end
