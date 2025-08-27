Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "web/bulletins#index"

  post 'auth/:provider', to: 'auth#request', as: :auth_request
  get "auth/:provider/callback", to: "web/auth#callback", as: :callback_auth
  get "auth/logout", to: "web/auth#logout", as: :auth_logout

  scope module: :web do
    resource :profile, controller: :profile, only: %i[show]

    resources :bulletins, only: %i[index new show create edit update archive] do
      member do
          post "archive"
          post "to_moderate"
      end
    end 

    namespace :admin do
      resources :categories, only: %i[index new edit update create destroy]
      resources :bulletins,  only: %i[index] do
        member do
          post "publish"
          post "archive"
          post "reject"
        end
      end

      root "bulletins#on_moderation"
    end
  end
end
