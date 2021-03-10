class UsersController < ApplicationController
  before_action :find_user, only: [:show, :follow, :unfollow]
  # before_action :average_rating, only: :index

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
  end

  def follow
    Following.create(follower: current_user, followee: @user)
    redirect_back(fallback_location: users_path)
  end

  def unfollow
    Following.find_by(follower: current_user, followee: @user).destroy
    redirect_back(fallback_location: users_path)
  end

  # def average_rating
  #   @recipe = Recipe.new
  #   reviews = @recipe.reviews
  #   ratings = []
  #   reviews.each do |review|
  #     ratings << review.rating
  #   end
  #   unless ratings.empty?
  #     @average_rating = (ratings.sum / ratings.size)
  #   end
  # end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
