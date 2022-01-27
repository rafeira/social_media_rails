class PostsController < ApplicationController
    def index
        @posts = current_user.friends.map { |friend| friend.posts}.flatten
    end

    def new
        @post = Post.new
    end

    def create
        post = Post.new(params.require(:post).permit(:title, :description))
        post.user = current_user
        post.save!
        redirect_to posts_path
    end
end
