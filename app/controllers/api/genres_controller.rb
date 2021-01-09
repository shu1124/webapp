class Api::GenresController < ApplicationController
  def index
    genres = Genre.all
    render json: genres, each_serializer: GenreSerializer
  end
end
