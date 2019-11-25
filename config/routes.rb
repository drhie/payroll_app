Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'payroll_reports#index'
  resources :time_reports, only: [:create]
end
