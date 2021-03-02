Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users

  resources :recipes do
    resources :ingredients, only: :create
    resources :reviews, only: [:create, :new]
    resources :bookmarks, only: [ :create ]
  end

  resources :reviews, only: :destroy
  resources :bookmarks, only: :destroy

  resources :bookmarks, only: [ :index, :show, :destroy ] do
    resources :notes, only: :create
  end

  resources :notes, only: :destroy
  resources :users, only: [:index, :show] do
    post :follow, on: :member
    delete :unfollow, on: :member
  end

  root to: 'pages#home'
end
