class FriendshipsController < ApplicationController
	before_action :filter_users, :set_users, only: [:search]
	before_action :set_user, only: [:follow, :unfollow]
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
end
