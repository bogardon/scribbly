class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to :root
    else
      render json: @user.errors.full_messages
    end
  end

  def destroy
  end

end
