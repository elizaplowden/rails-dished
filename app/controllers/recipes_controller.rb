class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

  private

  def find_recipe
    @recipe = Yurt.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:description, :instructions, :meal, :cuisine, :serves, :cook_time)
  end
end
