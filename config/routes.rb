Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :couples, only: [:show, :create, :update] do
    member do
      get :score_dashboard
    end
    resources :messages, only: [:index, :create]
    resources :rewards, except: [:destroy]
  end

  resources :generic_tasks, except: [:show]
  resources :generic_rewards, only: [:index, :update, :destroy]
  resources :tasks

end
