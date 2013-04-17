KatelloScholar::Application.routes.draw do
  devise_for :users do
    # get 'user/edit' => 'devise/registrations#edit'
  end

  root :to => 'dashboard#index'
  match 'dashboard' => 'dashboard#index', :as => :dashboard

  resources :courses do 
    get 'de_active', :on => :member
    get 'clone', :on => :member
    resources :seminars
    resources :templates
  end

  resources :seminars do
    resources :lessons
  end

  resources :templates do 
    resources :lessons
  end

  resources :lessons do
    get 'clone', :on => :member
  end

  resources :labs do
    resources :system_hosts
  end

  resources :system_hosts do
  end

  resources :users do
  end

  resources :operating_systems do
  end



  #match 'course/de_active/:id' => 'courses#de_active', :via => :get
  #match 'course/clone/:id' => 'courses#clone', :via => :get, :as => "clone_course"


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
  # 

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
