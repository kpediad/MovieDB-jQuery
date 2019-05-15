class ReviewsController < ApplicationController
  def index
    @movie = Movie.find(params[:movie_id])
    render 'movies/show'
  end

  def show
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
  end
end
