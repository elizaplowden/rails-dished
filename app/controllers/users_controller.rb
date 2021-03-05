class UsersController < ApplicationController
  before_action :find_user, only: [:follow, :unfollow]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = current_user
  end

  def follow
    Following.create(follower: current_user, followee: @user)
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
