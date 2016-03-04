Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  #get 'static_pages/home'
  #get 'static_pages/help'
  # 'static_pages/about'
  #get 'static_pages/contact'
  
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  
  get 'home' => 'static_pages#home'
  get 'signup' => 'users#new'
  resources :users
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  #root 'application#hello'
  root 'static_pages#home'
  
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
