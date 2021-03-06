TabiRepo::Application.routes.draw do

  get "/report/visitor" => "report#visitor"
  get "/report/article" => "report#article"
  get "/report/writer" => "report#writer"
  get "/report/date" => "report#date"

  get "/about_us/" => "about_us#index"
  get "/about_us/guidelines" => "about_us#guidelines"
  get "/about_us/guidance" => "about_us#guidance"
  get "/about_us/edit" => "about_us#edit"
  post "/about_us/" => "about_us#update"

  get "/contact/" => "contact#index"
  get "/contact/new" => "contact#new"
  post "/contact/" => "contact#create"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }#do
  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  resources :profiles, :except => ["create","new"]
  get "/profiles/:id/edit/password" => "profiles#password"
  put "/profiles/:id/password" => "profiles#update_password"

  
    # resources "users", :except=>["create","new"]

    # get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  # end

  #  get "top/index"
  resources :articles do
    collection do
      get :search
    end
  end
  get "/articles/search/latest" => "articles#search_as_latest"
  get "/articles/search/recommended" => "articles#search_as_recommended"
  get "/articles/search/popular" => "articles#search_as_popular"
  get "/articles/search/shoveler" => "articles#search_as_shoveler"
  get "/articles/search/related" => "articles#search_as_related"

  get "/articles/writer/:id" => "articles#writer"

  put "/articles/:id/approve" => "articles#approve"
  put "/articles/:id/disapprove" => "articles#disapprove"
  put "/articles/:id/recommend" => "articles#recommend"
  put "/articles/:id/disrecommend" => "articles#disrecommend"
  put "/articles/:id/apply" => "articles#apply"

  post "/imageupload" => "application#imageupload"
  post "/photoupload" => "application#photoupload"
  # post "/fileupload/articles/paragraph" => "articles#fileupload_paragraph"

  # get "/articles/user/:user_id" => "articles#user" # todo ログインユーザー、または管理者のみ 
  # get "/articles/unapproved/" => "articles#unapproved" # todo 管理者のみ


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
  root :to => 'top#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
