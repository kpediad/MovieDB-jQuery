class WelcomeController < ApplicationController
  def home
    render :generic_home, layout: 'generic' if !logged_in?
  end
end
