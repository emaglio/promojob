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
    member do
      get 'overview'
    end
    collection do
      post 'applications'
    end
  end

  get 'my/jobs', controller: :my, action: :jobs, as: "my_jobs"
  post "jobs/search", controller: :jobs, action: :search
  post 'users/block', controller: :users, action: :block

  resources :users do
    member do
      post 'block'
    end
  end
end