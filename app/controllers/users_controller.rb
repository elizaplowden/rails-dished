class UsersController < ApplicationController
  before_action :find_user, only: [:show, :follow, :unfollow]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
  end

  def follow
    Following.create(follower: current_user, followee: @user)
    Notification.create(recipient: @user, actor: current_user, action: "followed you", notifiable: @user)
    redirect_back(fallback_location: users_path)
  end

  def unfollow
    Following.find_by(follower: current_user, followee: @user).destroy
    redirect_back(fallback_location: users_path)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
