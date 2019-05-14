class MoviesController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index, :show,]

  def new
    @movie = Movie.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
  end

end
