Rails.application.routes.draw do
  root to: "users#new" # this is what the application shows when you access localhost:3000/.
  resources :users
  resources :jobs
  resources :job_applications
end
