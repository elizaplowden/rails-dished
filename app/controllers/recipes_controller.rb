class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_recipe, only: [:show, :destroy, :edit, :update]

  def index
    # used to populate the drop down list (select tag) in the search form
    @foods = Food.all
    # if statement so the recipes index still returns all recipes if there is no search term
    if params[:query].present?
      # using pgsearch - the search criteria is defined in the Recipe model
      @recipes = Recipe.search_by_food(params[:query])
    else
      @recipes = Recipe.all
    end
  end

  def show
    @bookmark = Bookmark.new
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

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :instructions, :meal, :cuisine, :serves, :cook_time)
  end
end
