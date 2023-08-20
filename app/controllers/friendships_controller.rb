class FriendshipsController < ApplicationController
	before_action :filter_users, :set_users, only: [:search]
	before_action :set_user, only: [:follow, :unfollow]
	before_action :load_current_user, only: [:search]
	def search; end

	def follow
		if current_user.follow(@user)
			@user.broadcast_update(partial: 'friendships/unfollow_link',
																locals: {user: @user})
		end
	end

	def unfollow
		if current_user.unfollow(@user)
			@user.broadcast_update(partial: 'friendships/follow_link',
																locals: {user: @user})
		end
	end

	private
	def filter_users
		@q = User.ransack(params[:q])
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
