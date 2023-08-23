# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_posts, only: [:index]
  def index; end

  def new
    @post = Post.new
  end

  def create
    current_user.posts.build(post_params).save!
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def set_posts
    following = current_user.following.includes(posts: [:user, :comments, { likes: :user }])
    @posts = following.map(&:posts).flatten(1)
  end
end
