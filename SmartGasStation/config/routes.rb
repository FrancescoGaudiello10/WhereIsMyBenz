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

  resources :stations, :implants do
    resources :comments, only: [:create, :destroy] #-> url.com/topics/:topic_id/comments
  end
  resources :calcs
  resources :prices
  resources :visits
  resources :stats

end
