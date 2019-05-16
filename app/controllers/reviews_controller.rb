class ReviewsController < ApplicationController
  def index
    @movie = Movie.find(params[:movie_id])
    render 'movies/show'
  end

  def show
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
  
end
