class PostCommentsController < ApplicationController
    before_action :get_post

    def index
        @comments = @post.comments.eager_load(:user, {likes: :user}, :comments)
        render 'posts/comments/index'
    end
    def new
        @comment = Comment.new
        render 'posts/comments/new'
    end
    def create
        comment = @post.comments.build(params.require(:comment).permit(:description))
        comment.user = current_user
        comment.save
        redirect_to post_comments_path post_id: @post.id
    end

    private
        def get_post
            @post = Post.find(params[:post_id])
        end
end
