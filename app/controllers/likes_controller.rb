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
    elsif @likeable.class == Comment
      if @likeable.commentable.class == Post
        redirect_to post_comments_path(post_id: @likeable.commentable.id)
      elsif @likeable.commentable.class == Comment
        redirect_to comment_comments_path(comment_id: @likeable.commentable.id)
      end
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
