class MoviesController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index, :show,]

  def new
    @movie = Movie.new
    @movie.reviews.build
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save then
      flash.notice = "New movie was created successfully!"
      redirect_to movies_path
    else
      flash.now.alert = "#{@movie.error_msg}"
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params) then
      flash.notice = "Movie details were updated successfully!"
      redirect_to movie_path(@movie)
    else
      flash.now.alert = "#{@movie.error_msg}"
      render :edit
    end
  end

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :release_year, :synopsis)
  end

end
