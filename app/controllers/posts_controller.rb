class PostsController < ApplicationController
    def index
        @posts = current_user.friends_posts.eager_load(:user, :comments, likes: :user)
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
