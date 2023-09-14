# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_author_ids, :set_posts, only: [:index]
  before_action :set_post, :load_current_user, only: %i[like dislike add_comment]
  after_action :broadcast_update, only: %i[like dislike add_comment]
  def index; end

  def new
    @post = Post.new
  end

  def create
    current_user.posts.build(post_params).save!
    redirect_to posts_path
  end

  def like
    nil unless @current_user.like(@post)
  end

  def dislike
    nil unless @current_user.dislike(@post)
  end

  def add_comment
    nil unless @post.update(post_params)
    @post.comments.reload
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, comments_attributes: %i[description user_id])
  end

  def set_author_ids
    @author_ids = current_user.following_ids
    @author_ids <<  current_user.id
  end

  def set_posts
    @posts = Post.where(user_id: @author_ids).includes(:user, :latest_comments_first,
                                                         { likes: :user }).order(created_at: :desc)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def load_current_user
    @current_user = User.includes(likes: :likeable).find(current_user.id)
  end

  def broadcast_update
    @post.broadcast_update(partial: 'posts/post',
                           locals: { post: @post, logged_user: @current_user })
  end
end
