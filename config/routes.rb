Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', :registrations => 'users/registrations'}
  #match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  #mount Sidekiq::Web, at: "/sidekiq"

  namespace :user do
    resource :profile, only: [:edit, :update, :destroy]
    resource :user, only: [:edit, :update]
  end
  get '/secret', to: 'users#index', as: :all_users
  resources :entries do
    collection do
      post :import
      get :autocomplete
      end
    resources :comments
    member do
      put "like", to: "entries#upvote"
      put "dislike", to: "entries#downvote"
    end
  end

  resources :feeds do
    member do
      get 'retrieve'
      post 'subscribe'
      post 'unsubscribe'
    end
  end
  #get '/secret', to: 'user#users#index', as: :all_users
  mount SuperfeedrEngine::Engine => SuperfeedrEngine::Engine.base_path # Use the same to set path in the engine initialization!


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
