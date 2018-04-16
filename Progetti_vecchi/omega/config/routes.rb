Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/profile'
  get 'welcome/results'
  get 'welcome/favourites'
  get 'welcome/following'

  post 'properties/:id/add_to_f', to: 'properties#add_to_f', as: 'add_to_f_property'
  post 'properties/:id/remove_from_f', to: 'properties#remove_from_f', as: 'remove_from_f_property'

  post 'properties/:id/follow', to: 'properties#follow', as: 'follow'
  post 'properties/:id/unfollow', to: 'properties#unfollow', as: 'unfollow'


  get 'properties/:id/summary', to: 'properties#summary', as: 'summary'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :properties do
    resources :prenotations

    resources :questions do
      resources :answers
    end
    
    resources :reviews
  end

  resources :conversations do
    resources :messages
  end
  resources :ratings
  resources :answer_ratings
  resources :reviews
  resources :questions
end
