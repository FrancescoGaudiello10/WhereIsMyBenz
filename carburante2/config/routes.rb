Rails.application.routes.draw do

  get 'welcome/index'
  get 'welcome/results'

  get 'implants/index'
  get 'implants/show'
  get 'implants/stats'

  get 'calcs/index'

  get 'profiles/index'
  get 'profiles/update'

  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks",
      :registrations => "registrations"
  }

  # match ':controller(/:action(/:id))', :via => :get

  root 'welcome#index'

  resources :stations do
    resources :comments
  end
  resources :implants
  resources :prices
  resources :calcs
  resources :profiles

end
