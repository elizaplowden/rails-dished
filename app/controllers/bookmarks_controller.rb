class BookmarksController < ApplicationController
  def create
    @bookmark = Bookmark.new(bookmark_params)
    # we need a cookbook id to associate bookmark with corresponding cookbook
    @bookmark.user = current_user
    # @recipe = Recipe.find(params[recipe_id])
    # @bookmark.recipe = @recipe
    if @bookmark.save
      flash[:notice] = "this saved"
    else
      flash[:alert] = "this did not save"
    end
    redirect_back(fallback_location: recipes_path)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    flash[:notice] = "this has been deleted"
    redirect_back(fallback_location: recipes_path)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:recipe_id)
  end
end
