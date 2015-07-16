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
    @collaborations = current_user.collaborations
    render json: @collaborations
  end

  def show
    @collaboration = current_user.collaborations.find(params[:id])
    render json: @collaboration
  end

  def destroy
  end

  private

  def collab_params
    params.require(:collaboration).permit(:name, :description)
  end
end
