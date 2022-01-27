module FriendsHelper
    def followed? friend
        current_user.friends.include? friend
    end
end
