Rails.application.routes.draw do

    get 'pages/home'

    get 'pages/profile'

    get 'pages/settings'

    get 'pages/search'

    get 'pages/add'

    get 'pages/statistics'

    get 'pages/results'

    get 'pages/details'

    get 'pages/calculate'

    match ':controller(/:action(/:id))', :via => :get

    #pagina principale
    root 'pages#search'

    resources :users
    resources :cars

end
