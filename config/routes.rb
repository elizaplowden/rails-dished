Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cookbook do
    resources :bookmarks, only [ :new, :create ]
  end

  resources :recipe do
    resources :ingredients, only [ :new, :create ]
    resources :reviews, only [ :new, :create ]
  end

  resources :bookmarks do
    resources :notes, only [ :new, :create ]
  end

  resources :notes, only [ :destroy ]
end
