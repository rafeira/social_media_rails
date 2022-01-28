class CommentCommentsController < ApplicationController
    before_action :get_comment

    def index
        @comments = @comment.comments
    end

    def new
        @comment = Comment.new
    end

    def create
        comment = @comment.comments.build(params.require(:comment).permit(:description))
        comment.user = current_user
        comment.save
        redirect_to comments_path
    end

    private
        def get_comment
            @comment = comment.find(params[:comment_id])
        end
end
