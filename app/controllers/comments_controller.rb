class CommentsController < ApplicationController
    before_action :get_commentable

    def index
        @comments = @post.comments
    end
    def new
        @comment = Comment.new
    end
    def create
        comment = @post.comments.build(params.require(:comment).permit(:description))
        comment.user = current_user
        comment.save
        redirect_to posts_path
    end

    def comment_comments
        @comments = @
    end
    private
        def get_commentable
            if params[:post_id]
                @likeable = Post.find(params[:post_id])
              elsif params[:comment_id]
                @likeable = Comment.find(params[:comment_id])
              end

        end
        def get_post
            if action_name == "new" or action_name == "index"
                @post = Post.find(params[:post_id])
            elsif action_name == "create"
                @post = Post.find(params[:comment][:post_id])
            end
        end
end
