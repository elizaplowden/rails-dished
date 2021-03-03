class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_recipe, only: [:show, :destroy, :edit, :update, :add_to_wishlist]

  def index
    # used to populate the drop down list (select tag) in the search form
    @foods = Food.all
    # if statement so the recipes index still returns all recipes if there is no search term
    if params.dig(:search, :query).present?
      # using pgsearch - the search criteria is defined in the Recipe model
      @recipes = Recipe.search_by_food(params.dig(:search, :query))
    else
      @recipes = Recipe.all
    end
  end

  def show
    @bookmark = current_user.bookmarks.find_by(recipe: @recipe)
    if @bookmark.nil?
      @bookmark = Bookmark.new
    end
    @note = Note.new(bookmark: @bookmark)
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
    if session[:recipe_id].present?
      if session[:recipe_id].include?(@recipe.id)
        session[:recipe_id].delete(@recipe.id)
      else
        session[:recipe_id] << @recipe.id
      end
    else
      session[:recipe_id] = [@recipe.id]
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
