Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :api do
    root :to => "home#index"

    post 'signup' => 'users#create'
    post 'signin' => 'sessions#create'
    post 'logout' => 'sessions#destroy'

    resources :users
    resources :posts
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
