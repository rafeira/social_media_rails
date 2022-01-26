class LikesController < ApplicationController
  before_action :get_post
  def create
    like = @post.likes.where(user: current_user).last
    if like
      like.destroy!
    else
      @post.likes.build(user: current_user).save!
    end
    redirect_to posts_path
  end
  private
    def get_post
      @post = Post.find(params[:post_id])
    end
end
