Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  match ':controller(/:action(/:id))', :via => :get
  match '/signup',  :to => 'users#new', :via => :get
end
