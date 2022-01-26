class CommentsController < ApplicationController
    before_action :get_post, only: [:new, :create]
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
            if action_name == "new"
                @post = Post.find(params[:post_id])
            elsif
                @post = Post.find(params[:comment][:post_id])
            end

        end
end
