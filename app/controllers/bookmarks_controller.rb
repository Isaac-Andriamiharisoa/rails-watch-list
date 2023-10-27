class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.create(bookmark_params)
    @list = List.find(@bookmark[:list_id])
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    redirect_to lists_path
  end

  private

  def bookmark_params
    params[:bookmark][:completed] = params[:bookmark][:completed] == '1'
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
