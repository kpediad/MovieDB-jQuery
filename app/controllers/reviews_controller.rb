class ReviewsController < ApplicationController
  before_action :require_login, :check_user
  skip_before_action :require_login, :check_user, only: [:index, :show,]

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

  private

  def check_user

  end

  def review_params
    params.require(:review).permit(:user_id, :content, :rating]) #temporary as need to test what needs to happen with movie_id
  end

end
