class PostsController < ApplicationController
    def index
        @posts = current_user.friends_posts.eager_load(:user, :comments, likes: :user)
    end

    def new
        @post = Post.new
    end

    def create
        current_user.posts.build(post_params).save!
        redirect_to posts_path
    end
    private
        def post_params
            params.require(:post).permit(:title, :description)
        end

end
