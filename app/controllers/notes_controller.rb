class NotesController < ApplicationController
  before_action :find_bookmark, only: [:new, :create]
  before_action :find_note, only: [:edit, :update, :destroy]

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(strong_params)
    @note.bookmark = @bookmark
    if @note.save!
      redirect_to recipe_path(@bookmark.recipe)
    else
      render(:new)
    end
  end

  def edit
  end

  def update
    @note.update(strong_params)
    if @note.save
      redirect_to recipe_path(@bookmark.recipe)
    else
      render :new
    end
  end

  def destroy
    @note.destroy
    @bookmark = @note.bookmark
    redirect_to recipe_path(@bookmark.recipe)
  end

  private

  def strong_params
    params.require(:note).permit(:description)
  end

  def find_bookmark
    @bookmark = Bookmark.find(params[:bookmark_id])
  end

  def find_note
    @note = Note.find(params[:id])
  end
end
