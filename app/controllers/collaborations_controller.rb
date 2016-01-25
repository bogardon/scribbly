class CollaborationsController < ApplicationController
  def new
    @user = current_user
    @collaboration = @user.collaborations.build
  end

  def create
    @user = current_user

    if @user.collaborations.create!(name: params[:name], description: params[:description])
      render json: @user.collaborations
      # redirect_to collaborations_url
    else
      render json: {error: "Collab create failed"}, status: 400
      # redirect_to collaborations_url
    end
  end

  def edit
  end

  def update
  end

  def index
    if current_user
      @collaborations = current_user.collaborations
      render json: @collaborations
    else
      render json: {error: "collab index failed"}, status: 400
    end
  end

  def show
    if request.xhr?
      @collaboration = current_user.collaborations.find(params[:id])
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
