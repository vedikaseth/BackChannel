BackChannelApp::Application.routes.draw do

  root :to => "login#login"
  get "posts/search_post_show"
  post "posts/destroy"

  get "posts/search_for_post"
  post "posts/search_post_show"
  post "comments/edit"

  get "users/save_new_user"

  get "users/post_user_save"
  post "users/destroy"

  get "posts/generate_report"
  post "posts/generate_report"
  get "posts/report"
  post "posts/report"
  post "comments/destroy"
  post "post_votes/destroy"
  post "post_votes/create"

  post "comment_votes/destroy"
  post "comment_votes/create"
  post "posts/search_for_post"
   post "users/update"

  post "login/user"
  get "login/user"

  post "login/admin"
  get "login/admin"

  get "login/login"
  post "login/login"
  post "login/logout"
  post "login/index"
  get "login/logout"

  get 'user/show'

  get 'posts/index'
  post 'posts/index'
post 'posts/edit'
  get 'login/index'

  get 'comments/new'
  post 'comments/new'
  post 'posts/new'

 get 'posts/show'




  resources :tags


  resources :comment_votes


  resources :post_votes


  resources :comments


  resources :categories


  resources :posts


  resources :users






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
  root :to => 'login#login'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
