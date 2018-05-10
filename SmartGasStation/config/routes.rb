Rails.application.routes.draw do

  get 'profiles/index'
  get 'welcome/index'

  get 'implants/index'
  get 'implants/show'
  
  get 'stats/index'
  get 'visits/index'
  get 'calcs/show'

  devise_for :users, 
  :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks",
      :registrations => "users/registrations"
  }

  root 'welcome#index'

  resources :stations 
  # do
  #   resources :comments
  # end
  resources :calcs
  resources :implants
  resources :prices
  resources :visits
  resources :stats

end
