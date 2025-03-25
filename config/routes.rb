Rails.application.routes.draw do
   #resources :blog_comments
  devise_for :admin_users, ActiveAdmin::Devise.config.merge(
    controllers: { omniauth_callbacks: 'admin_users/omniauth_callbacks' }
  )
  ActiveAdmin.routes(self)
  devise_for :users
  devise_for :views
      
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    root "articles#index"
    get "up" => "rails/health#show", as: :rails_health_check
    resources :users
    resources :articles do
        resources :blog_comments, only: %i[create destroy]
    end
    
    match '*unmatched', to: 'articles#not_found_method', via: :all
    # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
    # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
    # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

    # Defines the root path route ("/")
    # root "posts#index"
end
