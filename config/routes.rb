Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :pages, only: :home do
    patch "punch_action", on: :collection
    patch "kiss_action", on: :collection
    patch "love_action", on: :collection
    patch "peace_action", on: :collection
    patch "delete_action", on: :collection
  end
  resources :couples, only: [:show, :create, :update] do
    member do
      get :chatroom
    end
    resources :messages, only: [:index, :create] do
      # ci-après : création d'une route pour actionner la méthode trigger_autopilot à la réception d'un nouveau message
      post 'trigger_autopilot', on: :collection
    end

    resources :rewards, except: [:destroy] do
      collection do
        get 'given_rewards'
        get 'to_do_rewards'
        get 'created_rewards'
      end
      patch "mark_as_done", on: :member
    end
  end

  resources :generic_tasks, only: [:create, :update, :destroy]
  resources :generic_rewards, only: [:index, :show, :update, :destroy]

  resources :tasks do
    member do
      patch "mark_as_done"
    end
  end


  resources :statues, only: [:new, :create, :show] do
    # ci-après : ajout d'une route pour toggle le mode autopilot (création d'un nouveau statut)
    post "autopilot_toggle", on: :collection
  end

  get "score_dashboard", to: "pages#score", as: :score
  get "score_details", to: "pages#scoredetails", as: :score_details


  resources :calendars, only: [:index]
end
