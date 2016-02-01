class Api::PlatformsController < ApplicationController

  def index
    @platforms = Platform.all
    render json: @platforms
  end

end
