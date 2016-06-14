Rails.application.routes.draw do
  get 'about/company_overview'

  get 'about/compny_overview'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users, only: [:index, :show]
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
