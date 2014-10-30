Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  namespace :frontend, path: '/' do
    root 'home#index'
    resources :users
  end

end
