class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    genre.saved
    redirect_to genres_path(genre.id)
  end

  def edit
    @genre = Genre
  end

  def update

  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
