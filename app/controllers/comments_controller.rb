class CommentsController < ApplicationController
    before_action :get_post, only: [:new]
    def new
        @comment = Comment.new
    end
    def create
        @post.comments.build(params.require(:comment)).save
    end
    private
        def get_post
        @post = Post.find(params[:post_id])
        end
end
