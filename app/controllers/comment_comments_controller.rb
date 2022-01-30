class CommentCommentsController < ApplicationController
    before_action :get_comment

    def index
        @comments = @comment_parent.comments
        render 'comments/comment_comments/index'
    end

    def new
        @comment = Comment.new
        render 'comments/comment_comments/new'
    end

    def create
        comment = @comment_parent.comments.build(params.require(:comment).permit(:description))
        comment.user = current_user
        comment.save
        redirect_to comment_comments_path(comment_id: @comment_parent.id)
    end

    private
        def get_comment
            @comment_parent = Comment.find(params[:comment_id])
        end
end
