Rails.application.routes.draw do
  resources :comments
  resources :posts
  devise_for :users
  root to: "posts#index"
  resources :posts do
    resources :likes, shallow: true
  end
  resources :posts do
    resources :comments, shallow: true
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
