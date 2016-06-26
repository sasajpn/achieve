Rails.application.routes.draw do
  namespace :taskline do
    resources :task_comments
  end
  resources :tasks
  get 'relationships/create'

  get 'relationships/destroy'

  resources :comments
  
  get 'about/company_overview'
  
  get '/email' => 'email#recieve_email'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  resources :users, only: [:index, :show, :edit, :update] do
    resources :tasks
    member do
      get :following, :followers
    end
  end
  
  namespace :taskline do
    resources :tasks do
      resources :task_comment
      post "ungoodjob"
      post "goodjob"
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  root to: 'top#index'
  
  get 'helps/confirm' => 'helps#confirm'
  get 'helps/new' => 'helps#new'
  post 'helps/new' => 'helps#new'
  post 'helps/confirm' => 'helps#confirm'
  post '/helps' => 'helps#create'
  get 'helps/thanks' => 'helps#thanks'
  
  get 'about' => 'about#company_overview'
  
  resources :blogs do
    resources :comments
  end

end
