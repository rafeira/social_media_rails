class FriendshipsController < ApplicationController
	before_action :filter, :set_users, only: [:search]
	def search; end

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

	private
	def filter
		@q = User.eager_load(:friends).ransack(params[:q])
	end
	def set_users
		@users = @q.result(distinct: true)
	end
end
