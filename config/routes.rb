Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts do
    post 'likes', action: :create, controller: 'likes'
    delete 'likes/:like_id', action: :destroy, controller: 'likes'
    post 'comments', action: :create, controller: 'post_comments'
    delete 'comments/:comment_id', action: :destroy, controller: 'post_comments'
    get 'comments', action: :index, controller: 'post_comments'
    get 'comments/new', action: :new, controller: 'post_comments'
  end
  resources :comments do
    post 'likes', action: :create, controller: 'likes'
    delete 'likes/:like_id', action: :destroy, controller: 'likes'
    post 'comments', action: :create, controller: 'comment_comments'
    delete 'comments/:comment_id', action: :destroy, controller: 'comment_comments'
    get 'comments', action: :index, controller: 'comment_comments'
    get 'comments/new', action: :new, controller: 'comment_comments'
  end
  get 'all_users', action: :index, controller: 'all_users'
  post 'all_users/:user_id', action: :attach, controller: 'all_users'
  delete 'all_users/:user_id', action: :detach, controller: 'all_users'
  get 'all_users/:followers', action: :all_followers, controller: 'all_users'
  get 'all_users/:following', action: :all_following, controller: 'all_users'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
