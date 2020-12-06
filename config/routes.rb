Rails.application.routes.draw do
    root to: 'sessions#new'
  # ログイン/ログアウト
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :employees, only: %w(index edit update show destroy) do
    namespace :admin do
      resources :employees, only: %w(index new create show destroy)
      resources :employee_siklls, only: %w(new create)
    end
    resources :projects, except: %w(destroy)
    resources :employee_siklls, except: %w(new create)
  end

  resources :projects, only: %w(index show)

  resources :mst_skill_categories, only: [] do
    resources :mst_skills, only: %w(index)
  end
end
