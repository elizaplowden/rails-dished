class UsersController < ApplicationController
  before_action :find_user, only: [:show, :follow, :unfollow]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
  end

  def follow
    Following.create(follower: current_user, followee: @user)
    redirect_to user_path(@user)
  end

  def unfollow
    Following.find_by(follower: current_user, followee: @user).destroy
    redirect_to users_path
  end

  private

  def find_user
    @user = current_user
  end

end
