Rails.application.routes.draw do
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
  
  resources :blogs
  
  match "*path" => "application#handle_404", via: :all

end
