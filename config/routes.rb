Rails.application.routes.draw do
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
  
  #root 'application#hello'
  root 'static_pages#home'
end
