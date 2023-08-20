class FriendshipsController < ApplicationController
	before_action :filter_users, :set_users, only: [:search]
	before_action :set_user, only: [:follow, :unfollow]
	before_action :load_current_user, only: [:search]
	def search; end

	def follow; end

	def unfollow; end

	private
	def filter_users
		@q = User.eager_load(:friends).ransack(params[:q])
	end

	def set_users
		@users = @q.result(distinct: true)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def load_current_user
		@current_user = User.includes(user_connections: :requested).find(current_user.id)
	end
end
