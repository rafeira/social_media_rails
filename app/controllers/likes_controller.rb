class LikesController < ApplicationController
  before_action :get_likeable
  def create
    like = @likeable.likes.where(user: current_user).last
    if like
      like.destroy!
    else
      @likeable.likes.build(user: current_user).save!
    end
    if @likeable.class == Post
      redirect_to posts_path
    elsif @likeable.class == Comment
      redirect_to comments_path(post_id: @likeable.commentable.id)
    end
  end
  private
    def get_likeable
      if params[:post_id]
        @likeable = Post.find(params[:post_id])
      elsif params[:comment_id]
        @likeable = Comment.find(params[:comment_id])
      end
    end

    def create_post_like post

    end
end
