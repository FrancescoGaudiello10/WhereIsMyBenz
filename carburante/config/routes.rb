Rails.application.routes.draw do

    #pagina principale
    root 'users#index'

    match ':controller(/:action(/:id))', :via => :get

    resources :users
    resources :cars
    
end
