module AllUsersHelper
    def followed? user
        current_user.friends.include? user
    end
    def follower? user
        user.friends.include? current_user
    end
end
