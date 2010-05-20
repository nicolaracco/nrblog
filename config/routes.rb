Nrblog::Application.routes.draw do |map|
  devise_for :authors, :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  scope '(/:locale)' do
    controller :home do
      get '/' => :index, :as => :index
    end

    scope '/admin' do
      resources :categories, :except => :show
      resources :menu_items, :except => :show do
        post '/change_order' => :change_order, :as => :change_order, :on => :collection
        post '/change_type' => :change_type, :as => :change_type, :on => :collection
      end
      resources :images
      resources :blocks, :except => :show do
        post '/change_order' => :change_order, :as => :change_order, :on => :collection
        post '/change_type' => :change_type, :as => :change_type, :on => :collection
      end
      resources :tags, :except => :show
      resources :contents, :except => :show do
        delete '/:aid' => :destroy_attachment, :as => :destroy_attachment, :on => :member
        get '/add_attachment' => :add_attachment, :as => :add_attachment, :on => :collection
        post '/preview' => :preview_content, :as => :preview_content, :on => :collection
      end
    end

    controller :categories do
      scope '/content' do
        get '/:url_alias' => :show, :as => :show_category
      end
    end
    controller :tags do
      scope '/tags' do
        get '/:tag' => :show, :as => :show_tag
      end
    end
    controller :contents do
      scope '/content/:category_alias/:url_alias' do
        get '/' => :show, :as => :show_content
        resources :comments
      end
    end
  
    controller :contact do
      scope '/contact/:author' do
        get '/' => :index
        post '/' => :send_mail
      end
    end
  end

  root :to => 'home#index'

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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

  #root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
