class AllUsersController < ApplicationController
    def index
        @all_users = User.all
        render 'all_users/index'
    end
    def attach
        user = User.find params.require(:user_id)
        current_user.friends << user
        redirect_to all_users_path
    end
    def detach
        user = User.find params.require(:user_id)
        current_user.friends.delete(user)
        redirect_to all_users_path
    end
end
