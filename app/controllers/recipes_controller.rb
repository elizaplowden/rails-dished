class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_recipe, only: [:show, :destroy, :edit, :update]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    @recipe.save
  end

  def destroy
    @recipe.destroy
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:description, :instructions, :meal, :cuisine, :serves, :cook_time)
  end
end
