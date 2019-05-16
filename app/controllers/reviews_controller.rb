class ReviewsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index, :show,]

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
    raise params.inspect

  end

  def edit
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
  end

  def update

  end

  def destroy

  end

end
