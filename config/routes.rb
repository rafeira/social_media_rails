Rails.application.routes.draw do
  resources :posts
  devise_for :users
  root to: "posts#index"
  resources :posts do
    resources :likes, shallow: true
  end
  resources :posts do
    resources :comments, shallow: true
  end
  get 'friends', action: :index, controller: 'friends'
  post 'friends/:friend_id', action: :attach, controller: 'friends'
  delete 'friends/:friend_id', action: :detach, controller: 'friends'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
