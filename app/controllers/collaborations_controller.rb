class CollaborationsController < ApplicationController
  def new
    @user = current_user
    @collaboration = @user.collaborations.build
  end

  def create
    @user = current_user

    if @user.collaborations.create!(collab_params)
      redirect_to collaborations_url
    else
      redirect_to collaborations_url
    end
  end

  def edit
  end

  def update
  end

  def index
    if current_user
      @collaborations = current_user.collaborations
      if request.xhr?
        render json: @collaborations
      end
    else
      render json: 'Hello!'
    end
  end

  def show
    @collaboration = current_user.collaborations.find(params[:id])
    if request.xhr?
      render json: @collaboration
    end
  end

  def destroy
  end

  private

  def collab_params
    params.require(:collaboration).permit(:name, :description)
  end
end
