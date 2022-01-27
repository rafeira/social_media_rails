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
  get 'all_users', action: :index, controller: 'all_users'
  post 'all_users/:user_id', action: :attach, controller: 'all_users'
  delete 'all_users/:user_id', action: :detach, controller: 'all_users'
  get 'all_users/:followers', action: :all_followers, controller: 'all_users'
  get 'all_users/:following', action: :all_following, controller: 'all_users'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
