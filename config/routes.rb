Rails.application.routes.draw do

  mount ExceptionTrack::Engine => "/exception-track"  #TODO need admin user permission, refactor
  mount StatusPage::Engine, at: '/'
  # scope "(:locale)", :locale => /en|zh|th|en-AU|en-US|en-UK|zh-TW|es/ do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, path: 'user', controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}
  devise_scope :user do
    post '/admin/is_uid_exist', to: 'users/registrations#is_uid_exist'
  end

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'home#index'
  get '/about_us', to: 'home#about_us'

  resources :posts do
    collection do
      get :no_reply
      get :popular
      get :recent
      get :excellent
      get :favorites
    end
  end
  resources :posts, only: [:show] do
    resources :replies, only: [:create]
  end

  resources :replies, only: [:destroy, :index] do
    member do
      post 'hide', to: 'replies#hide'
      post 'restore', to: 'replies#restore'
    end
  end

  resources :codes

  resources :blogs #TODO TYPO

  resources :messages, only: [:show, :destroy, :index] do
    member do
      post 'mark_as_read', to: 'messages#mark_as_read'
    end
  end

  resources :users do
    member do
      get '/', to: 'users#show'
      get '/home', to: 'users#home'
      get '/profile', to: 'users#profile'
      get '/calendar', to: 'users#calendar'
      post '/update_profile', to: 'users#update_profile'
    end

    resources :categories
    resources :codes
    resources :replies, only: [:destroy, :index] do
      member do
        post 'hide', to: 'replies#hide'
        post 'restore', to: 'replies#restore'
      end
    end
  end

  get '/search' => 'search#index', as: 'search'

end
