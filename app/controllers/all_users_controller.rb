class AllUsersController < ApplicationController
    def index
        @q = User.all.eager_load(:friends).ransack(params[:q])
        @all_users = @q.result(distinct: true)
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
