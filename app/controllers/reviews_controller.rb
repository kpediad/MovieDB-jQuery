class ReviewsController < ApplicationController
  before_action :require_login
  before_action :validate_movie
  before_action :validate_review
  before_action :validate_user, only: [:edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show,]
  skip_before_action :validate_review, only: [:index, :new, :create]

  def index
    render 'movies/show'
  end

  def show
  end

  def new
    @review = @movie.reviews.build
  end

  def create
    raise params.inspect

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def validate_review
    @review = @movie.reviews.find(params[:id])
    if !@review then
      flash.alert = "Requested review does not exist!"
      redirect_to movie_path(@movie)
    end
  end

  def validate_user
    if @review.user != current_user then
      flash.alert = "You are not allowed to modify this review!"
      redirect_to movie_review_path(@movie, @review)
    end
  end

  def review_params
    params.require(:review).permit(:user_id, :content, :rating]) #temporary as need to test what needs to happen with movie_id
  end

end
