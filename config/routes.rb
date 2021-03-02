Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cookbook do
    resources :bookmarks, only: :create
  end

  resources :recipes do
    resources :ingredients, only: :create
    resources :reviews, only: [:create, :new]
  end

  resources :reviews, only: :destroy

  resources :bookmarks, only: [ :index, :show, :destroy ] do
    resources :notes, only: [:create, :new]
  end

  resources :notes, only: [ :update, :destroy ]
  resources :users, only: [:index, :show] do
    post :follow, on: :member
    delete :unfollow, on: :member
  end

end
