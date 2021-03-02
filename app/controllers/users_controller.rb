class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    Following.create(follower: current_user, followee: @user)
    redirect_to user_path(@user)
  end

  def unfollow
    @user = User.find(params[:id])
    Following.find_by(follower: current_user, followee: @user).destroy
    redirect_to users_path
  end



end
