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
    resources :messages, only: [:index, :create]

    resources :rewards, except: [:destroy] do
      collection do
        get 'given_rewards'
        get 'to_do_rewards'
        get 'created_rewards'
      end
      patch "mark_as_done", on: :member
    end
  end

  resources :generic_tasks, except: [:show]
  resources :generic_rewards, only: [:index, :show, :update, :destroy]
  resources :tasks

  get "score_dashboard", to: "pages#score", as: :score

end
