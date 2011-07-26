ImageEdit::Application.routes.draw do

  delete "paintings/delete/:id/:pid" => "paintings#delete"
  post "paintings/edit/:id" => "paintings#format" 
  get "paintings/download/:id" => "paintings#download"
  get "paintings/showall/:id" => "paintings#showall"
  get "paintings/edit/:id" => "paintings#edit"
  get "users/paintings" => "users#paintings"
  put "paintings/upload/:id" => "paintings#create"
  get "paintings/upload/:id" => "paintings#upload"
  get "home/index"
  put "users/update/:id" => "users#update"
  post"users/edit/:id" => "users#update"
  get "users/edit/:id" => "users#edit"
  get "users/all" => "users#all"
  get "users/destroy/:id" => "users#destroy"
  devise_for :users, :user
  root :to => "home#index"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
