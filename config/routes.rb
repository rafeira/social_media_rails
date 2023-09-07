# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  root 'posts#index'
  resources :posts do
    post 'likes', action: :create, controller: 'likes'
    delete 'likes', action: :destroy, controller: 'likes'

    post 'comments', action: :create, controller: 'post_comments'
    delete 'comments/:comment_id', action: :destroy, controller: 'post_comments'

    get 'comments', action: :index, controller: 'post_comments'
    get 'comments/new', action: :new, controller: 'post_comments'
    post 'like', to: 'posts#like', on: :member
    delete 'dislike', to: 'posts#dislike', on: :member
    patch 'add_comment', to: 'posts#add_comment', on: :member
  end
  resources :comments do
    post 'likes', action: :create, controller: 'likes'
    delete 'likes/:like_id', action: :destroy, controller: 'likes'
    post 'comments', action: :create, controller: 'comment_comments'
    delete 'comments/:comment_id', action: :destroy, controller: 'comment_comments'
    get 'comments', action: :index, controller: 'comment_comments'
    get 'comments/new', action: :new, controller: 'comment_comments'
  end
  namespace :users do
    namespace :profile do
      get 'add_name', to: 'update_data#add_name'
      patch 'add_name', to: 'update_data#update'
    end
  end
  resources :friendships, only: [] do
    get 'search', to: 'friendships#search', on: :collection
    post 'follow', to: 'friendships#follow', on: :member
    delete 'unfollow', to: 'friendships#unfollow', on: :member
  end
end
