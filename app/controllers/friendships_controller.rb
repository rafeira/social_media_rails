# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :filter_users, :set_users, only: [:search]
  before_action :set_user, only: %i[follow unfollow]
  before_action :load_current_user, only: %i[search follow unfollow]
  def search; end

  def follow
    return unless @current_user.follow(@user)

    @user.followers.reload
    @user.broadcast_update(partial: 'friendships/user',
                           locals: { user: @user, logged_user: @current_user })
  end

  def unfollow
    return unless @current_user.unfollow(@user)

    @user.followers.reload
    @user.broadcast_update(partial: 'friendships/user',
                           locals: { user: @user, logged_user: @current_user })
  end

  private

  def filter_users
    @q = User.includes(:followers).where.not(id: current_user.id).ransack(params[:q])
  end

  def set_users
    @users = @q.result(distinct: true)
  end

  def set_user
    @user = User.includes(:followers).find(params[:id])
  end

  def load_current_user
    @current_user = User.includes(requested_connections: :requested).find(current_user.id)
  end
end
