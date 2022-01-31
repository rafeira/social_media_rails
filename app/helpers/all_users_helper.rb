module AllUsersHelper
    def followed? user
        current_user.friends.to_a.include? user
    end
    def follower? user
        user.friends.to_a.include? current_user
    end
end
