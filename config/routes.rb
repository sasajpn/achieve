Rails.application.routes.draw do
  get 'about/company_overview'
  
  get '/email' => 'email#recieve_email'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users, only: [:index, :show, :edit, :update]
  root to: 'top#index'
  
  get 'helps/confirm' => 'helps#confirm'
  get 'helps/new' => 'helps#new'
  post 'helps/new' => 'helps#new'
  post 'helps/confirm' => 'helps#confirm'
  post '/helps' => 'helps#create'
  get 'helps/thanks' => 'helps#thanks'
  
  get 'about' => 'about#company_overview'
  
  resources :blogs

end
