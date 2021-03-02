class NotesController < ApplicationController
  before_action :find_bookmark, only: [:new, :create]

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(strong_params)
    @note.bookmark = @bookmark
    @note.user = current_user
    if @note.save
      redirect_to bookmark_path(@bookmark.id)
    else
      render(:new)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    @bookmark = @note.bookmark
    redirect_to bookmark_path(@bookmark.id)
  end

  private

  def strong_params
    params.require(:note).permit(:description)
  end

  def find_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

end
