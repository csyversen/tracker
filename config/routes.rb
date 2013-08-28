Tracker::Application.routes.draw do
  get "users/new"
  #get "auth/index"
  #get "auth/login"
  #get "auth/logout"
  #post "auth/attempt_login"

  match '/login',             to: 'auth#login',         via: 'get'
  match '/logout',            to: 'auth#logout',        via: 'get'
  match 'auth/attempt_login', to: 'auth#attempt_login', via: 'post'
  match 'tracking/menu',      to: 'tracking#menu',      via: 'get'
  match 'auth/new',           to: 'auth#new',           via: 'get'
  match 'auth/create',        to: 'auth#create',        via: 'post'
  match 'tracking/create',    to: 'tracking#create',    via: 'post'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'auth#login'

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
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
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
