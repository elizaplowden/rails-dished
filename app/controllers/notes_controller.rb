class NotesController < ApplicationController
  before_action :find_bookmark, only: [:new, :create]
  before_action :find_note, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    @note.update(strong_params)
    if @note.save
      redirect_to bookmark_path(@bookmark.id)
    else
      render :new
    end
  end

  def destroy
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

  def find_note
    @note = Note.find(params[:id])
  end

end
