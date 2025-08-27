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

  get "auth/:provider/callback", to: "web/auth#callback", as: :callback_auth
  get "auth/logout", to: "web/auth#logout", as: :auth_logout

  scope module: :web do
    resources :bulletins, only: %i[index new show create edit update archive]
    get "profile/index", as: :profile
    post "/bulletins/:id/arhive", to: "bulletins#archive", as: :archive_bulletin
    post "/bulletins/:id/to_moderate", to: "bulletins#to_moderate", as: :to_moderate_bulletin

    namespace :admin do
      resources :categories, only: %i[index new edit update create destroy]
      resources :bulletins,  only: %i[index]

      root "bulletins#on_moderation"
    end

    post "admin/bulletin/:id/publish", to: "admin/bulletins#publish", as: "publish_admin_bulletin"
    post "admin/bulletin/:id/archive", to: "admin/bulletins#archive", as: "archive_admin_bulletin"
    post "admin/bulletin/:id/reject", to: "admin/bulletins#reject", as: "reject_admin_bulletin"
  end
end
