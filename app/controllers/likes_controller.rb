# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_likeable
  # rubocop:disable Metrics/AbcSize
  def create
    if @likeable.instance_of?(Post)
      render 'posts/like' if @likeable.likes.first_or_create!(user: current_user)
    elsif @likeable.instance_of?(Comment)
      if @likeable.commentable.instance_of?(Post)
        redirect_to post_comments_path(post_id: @likeable.commentable.id)
      elsif @likeable.commentable.instance_of?(Comment)
        redirect_to comment_comments_path(comment_id: @likeable.commentable.id)
      end
    end
  end

  # rubocop:enable Metrics/AbcSize
  def destroy
    like = @likeable.likes.where(user: current_user).last
    return unless like

    like.destroy!
    render 'posts/like'
  end

  private

  def set_likeable
    if params[:post_id]
      @likeable = Post.find(params[:post_id])
    elsif params[:comment_id]
      @likeable = Comment.find(params[:comment_id])
    end
  end

  def create_post_like(post); end
end
