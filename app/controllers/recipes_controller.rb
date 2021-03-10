class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :find_recipe, only: [:show, :destroy, :edit, :update, :upload, :add_to_wishlist, :average_rating]
  # before_action :average_rating, only: :show
  before_action :foods, only: [:index, :new]
  before_action :find_search_terms, only: [:index]

  def index
    # if statement so the recipes index still returns all recipes if there is no search term
    # also it removes any blank values from the search array
    if params.dig(:search, :query).present? && !params.dig(:search, :query).reject(&:blank?).empty?
        # using pgsearch - the search criteria is defined in the Recipe model
        @recipes = Recipe.search_by_food(params.dig(:search, :query))
    # elsif passing params to filter by cuisine
    elsif params.key?(:cuisine_type)
      @recipes = Recipe.where(cuisine: params[:cuisine_type])
    else
      @recipes = Recipe.all
    end
  end

  def show
    @review = Review.new
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
    # recipe_params = recipe_params.to_hash
    # recipe_params[:ingredients_attributes] = recipe_params[:ingredients_attributes].select { |i| i[:quantity].present? }
    # recipe_params.deep_transform_keys!(&:compact)
    ingredients_attributes = params[:recipe][:ingredients_attributes]
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      ingredients_attributes.map! { |attribute| Ingredient.create!(food_id: attribute[:food_id], quantity: attribute[:quantity], recipe: @recipe) if attribute[:quantity].present? }
      @recipe.ingredients = ingredients_attributes.reject(&:nil?)
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  # uploading user images
  def upload
    @images = recipe_params[:images]
    @recipe.images.attach(@images)
    redirect_to recipe_path(@recipe, anchor: "user-image-uploads")
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  def add_to_wishlist
    if session[:recipe_id].present?
      if session[:recipe_id].include?(@recipe.id)
        session[:recipe_id].delete(@recipe.id)
        flash[:notice] = "Removed from Dishlist"
      else
        session[:recipe_id] << @recipe.id
        flash[:notice] = "Added to Dishlist"
      end
    else
      session[:recipe_id] = [@recipe.id]
      flash[:notice] = "Added to Dishlist"
    end
    redirect_back(fallback_location: recipes_path)
  end

  # def average_rating
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

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :instructions, :meal, :cuisine, :serves, :cook_time, :photo, images: [] )
  end

  def foods
    # gets a list of all the foods in the Foods table and sorts them alphabetically by name
    @foods = Food.order(:name)
  end

  def find_search_terms
    if params[:search]
      @search_terms = params[:search][:query]
    else
      @search_terms = params[:search]
    end
  end
end
