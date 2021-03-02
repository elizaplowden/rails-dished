class ReviewsController < ApplicationController
  before_action :find_recipe, only: [:create, :new]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(strong_params)
    @review.recipe = @recipe
    if @review.save
      redirect_to recipe_path(@recipe.id)
    else
      render(:new) # render the new.html.erb
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    @recipe = @review.recipe
    redirect_to recipe_path(@recipe.id)
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def strong_params
    params.require(:review).permit(:description, :rating)
  end
end


