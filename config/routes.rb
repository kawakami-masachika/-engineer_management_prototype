Rails.application.routes.draw do
  # get 'employee_skill/new'
  resources :employees do
    resources :employee_siklls
  end
end
