class WelcomeController < ApplicationController
  def home
    render :splash if !logged_in?
  end
end
