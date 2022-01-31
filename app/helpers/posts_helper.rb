module PostsHelper
    def liked? likes
        likes.map do |like|
            if like.user == current_user
                return true
            end 
        end
        false
    end

end
