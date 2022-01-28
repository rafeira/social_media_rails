class PostCommentsController < ApplicationController
    before_action :get_post

    def index
        @comments = @commentable.comments
        render 'comments/index'
    end
    def new
        @comment = Comment.new
        render 'comments/new'
    end
    def create
        
        binding.pry
        
        comment = @commentable.comments.build(params.require(:comment).permit(:description))
        comment.user = current_user
        comment.save
        redirect_to post_comments_path post_id: @post.id
    end

    private
        def get_post
            @commentable = Post.find(params[:post_id])
        end
end
