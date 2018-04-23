Rails.application.routes.draw do

  get 'welcome/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  match ':controller(/:action(/:id))', :via => :get
  
  root 'welcome#index'

end
