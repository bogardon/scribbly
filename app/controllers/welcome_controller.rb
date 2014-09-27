class WelcomeController < ApplicationController

  def index
    if current_user
      redirect_to collaborations_url
    else
      render 'index'
    end
  end

end
