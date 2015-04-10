class MembershipsController < ApplicationController
  def index
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])
    if @collaboration
      @memberships = @collaboration.memberships.includes(:user)
      render json: @memberships.to_json(include: :user)
    else
      render json: nil, status: 400
    end
  end

  def create
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])
    @user = User.find_by_email(params[:user][:email]) || User.invite!(email: params[:user][:email])
    @membership = @collaboration.memberships.find_or_initialize_by(user_id: @user.id)
    if @membership.persisted?
      render json: nil, status: 400
    elsif @membership.save
      render json: @membership.to_json(include: :user)
    end
  end

  def destroy
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])
    @membership = Membership.find_by_id(params[:id])
    if @membership.user_id != current_user.id && @membership.destroy
      render json: {status: :ok}
    else
      render json: nil, status: 400
    end
  end
end
