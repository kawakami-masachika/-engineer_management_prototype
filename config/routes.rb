Rails.application.routes.draw do
  root to: 'employees#index'
  # ログイン/ログアウト
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :employees do
    resources :projects, except: %w(destroy)
    resources :employee_siklls
  end

  resources :projects, only: %w(index show)

  resources :mst_skill_categories, only: [] do
    resources :mst_skills, only: %w(index)
  end

end
