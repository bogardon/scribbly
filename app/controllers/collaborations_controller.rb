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
  end

  def show
  end

  def destroy
  end

  private

  def collab_params
    params.require(:collaboration).permit(:name, :description)
  end

end
