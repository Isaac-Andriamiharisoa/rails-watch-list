class ListsController < ApplicationController
  def index
    @lists = List.all
    @movies = Movie.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.create(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movies
  end

  private

  def list_params
    params[:list][:completed] = params[:list][:completed] == '1'
    params.require(:list).permit(:name)
  end
end
