Rails.application.routes.draw do
  root to: 'members#index'

  resources :members 
  resources :teams 
  resources :projects do
    member do
      patch :add_to_project
      patch :remove_to_project
    end
  end
end
