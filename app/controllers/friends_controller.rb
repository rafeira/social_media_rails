class FriendsController < ApplicationController
    def index
        @friends = User.all
        render 'friends/index'
    end
    def attach
        friend = User.find params.require(:friend_id)
        current_user.friends << friend
        redirect_to friends_path
    end
    def detach
        friend = User.find params.require(:friend_id)
        current_user.friends.delete(friend)
        redirect_to friends_path
    end
end
