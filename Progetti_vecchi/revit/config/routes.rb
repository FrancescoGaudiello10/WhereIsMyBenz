Rails.application.routes.draw do
  resources :reports
  post 'feedbacks/create'
  post 'evaluations/create'
  get 'owners/new'
  get 'search/index'
  get 'password_resets/new'
  post 'reports/create'
  get 'password_resets/edit'
  
  get 'sessions/new'
  get 'users/:id/my_review'=> 'users#my_review'
  get  'signup' => 'users#new'
  get  'signupowners' => 'owners#new'
  get  'categories' => 'items#categories'
  get 'home' => 'static_pages#home'
  get 'items/search'
  get 'avd_search'=>'search'




  get 'help' => 'static_pages#help'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get    'loginowners'   => 'sessions#new_own'
  post   'loginowners'   => 'sessions#create_own'
  delete 'logoutowners'  => 'sessions#destroy_own'


  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure' => redirect('/')
  get 'signout' => 'sessions#destroy', as: 'signout'
  
  resources :feedbacks,  only: [:new,:create]
  resources :evaluation, only: [:new, :create]
  resources :contacts
  resources :owners
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new,:create,:edit, :update]
  resources :adds 
  
  

  resources :items  do
    resources :reviews do
      member do
        put "positive" => "reviews#upvote"
        put "negative" => "reviews#downvote"
      end
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #ggetti ruby on rails
  #     collection do
  #       get 'sold'
  #     end
  #   endggetti ruby on rails

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   endggetti ruby on rails

  # Example resource route with more complex sub-resources:ggetti ruby on rails
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
