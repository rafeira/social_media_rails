module PostsHelper
    def liked? post
        post.likes.where(user: current_user).last
    end
end
