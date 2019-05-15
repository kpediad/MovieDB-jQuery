class ReviewsController < ApplicationController
  def index
    @movie = Movie.find(params[:id])
    render 'movies/show'
  end
end
