Rails.application.routes.draw do
  root to: "jobs#index" # this is what the application shows when you access localhost:3000/.
  resources :users
  resources :jobs
  resources :job_applications
  
  resources :sessions do
    collection do
      get 'sign_out'
    end
  end

  resources :job_applications do
    collection do
      post 'applied'
    end
  end

  post "jobs/search", controller: :jobs, action: :search
      

end