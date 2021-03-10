class BookmarksController < ApplicationController
  def create
    @bookmark = Bookmark.new(recipe: Recipe.find(params[:recipe_id]))
    # we need a cookbook id to associate bookmark with corresponding cookbook
    @bookmark.user = current_user
    # @recipe = Recipe.find(params[recipe_id])
    # @bookmark.recipe = @recipe
    if @bookmark.save
      flash[:notice] = "Saved to your cookbook."
    Notification.create(recipient: @bookmark.recipe.user, actor: current_user, action: "bookmarked your recipe", notifiable: recipe.user)
    else
      flash[:alert] = "This did not save"
    end
    redirect_back(fallback_location: recipes_path)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    flash[:notice] = "Removed from your cookbook."
    redirect_back(fallback_location: recipes_path)
  end

  private

  # def bookmark_params
  #   params.require(:bookmark).permit(:recipe_id)
  # end
end
