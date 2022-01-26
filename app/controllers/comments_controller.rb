class CommentsController < ApplicationController
    before_action :get_post, only: [:new]
    def new
        @comment = Comment.new
    end
    def create
        comment = @post.comments.build(params.require(:comment).permit(:description))
        comment.user = current_user
        comment.save
        redirect_to posts_path
    end
    private
        def get_post
        @post = Post.find(params[:post_id])
        end
end
