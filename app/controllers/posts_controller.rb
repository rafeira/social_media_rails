# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_posts, only: [:index]
  before_action :set_post, :load_current_user, only: %i[like dislike]
  def index; end

  def new
    @post = Post.new
  end

  def create
    current_user.posts.build(post_params).save!
    redirect_to posts_path
  end

  def like
    return unless @current_user.like(@post)

    @post.broadcast_update(partial: 'posts/post',
                           locals: { post: @post, logged_user: @current_user })
  end

  def dislike
    return unless @current_user.dislike(@post)

    @post.broadcast_update(partial: 'posts/post',
                           locals: { post: @post, logged_user: @current_user })
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def set_posts
    following = current_user.following.includes(posts: [:user, :comments, { likes: :user }])
    @posts = following.map(&:posts).flatten(1)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def load_current_user
    @current_user = User.includes(likes: :likeable).find(current_user.id)
  end
end
