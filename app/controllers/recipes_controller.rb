class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_recipe, only: [:show, :destroy, :edit, :update, :add_to_wishlist]

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
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  def add_to_wishlist
    if session[:recipe].present?
      if session[:recipe].include?(@recipe)
        session[:recipe].delete(@recipe)
      else
        session[:recipe] << @recipe
      end
    else
      session[:recipe] = [@recipe]
    end
    flash[:notice] = "success!"
    redirect_back(fallback_location: recipes_path)
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :instructions, :meal, :cuisine, :serves, :cook_time)
  end
end
