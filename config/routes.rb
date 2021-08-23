Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations"}
  resources :users, path: "u", only: %w[show], param: :username

  get "links/minecraft" => "links#minecraft"
  post "links" => "links#create"

  # API Endpoints
  namespace :api do
    # Internal Endpoints are not given to any external users, and are subject
    # to change at any time without prior notice.
    # These are commonly used in scripts for automation.
    namespace :internal do
      resource :whitelist, only: %w[show]
    end
  end

  resources :whitelist_requests, path: "join"
  resources :revisions
  resources :casts

  resources :downloads, only: %w[index]

  resources :notifications do
    collection { post :mark_as_read }
  end
  namespace :admin do
    resources :servers, only: %w[index show new create edit update] do
    end
    resources :downloads
    resources :users do
      collection do
        get :email_list
        get :whitelisted
      end
    end

    namespace :whitelist_requests, path: "whitelist-requests" do
      resources :charts, only: %w[index]
    end
    resources :whitelist_requests, path: "whitelist-requests" do
      collection do
        get :pending
        get :approved
        get :denied
        patch :approve
        patch :deny
        delete :destroy
      end
    end
  end

  resources :forum_threads, path: "forum" do
    resources :forum_posts, path: "posts", module: :forum_threads
    member do
      patch :sticky
      patch :unsticky
    end
    collection do
      get "category/:id", to: "forum_categories#index", as: :forum_category
    end
  end

  root "pages#home"

  get "/support", to: redirect("/subscribe")
  get "information" => "pages#information"
  get "stats" => "pages#stats"
  get "/change_log", to: redirect("/revisions")
  get "subscribe" => "pages#subscribe"
  get "servers" => "servers#home"
  get "servers/vanilla" => "servers#vanilla"
  get "servers/rrr" => "servers#rrr"
  get "servers/direwolf20" => "servers#direwolf20"
  get "servers/snapshot" => "servers#snapshot"
end
