Rails.application.routes.draw do
  # Root
  root 'groups#index'

  # Auth
  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users do
   resource :password, controller: 'clearance/passwords', only: [:create, :edit, :update]
  end

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  get '/sign_up' => 'users#new', as: 'sign_up'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'

  #Resouces
  resources :groups
  resources :topics
  resources :subscriptions, only: [:create, :destroy]

  #Get
  get '/requirement_values/:group_id/:user_id/new', to: 'requirement_values#new'

  #Post
  post '/requirement_values/:group_id/:user_id/', to: 'requirement_values#create', as: 'requirement_values'
end
