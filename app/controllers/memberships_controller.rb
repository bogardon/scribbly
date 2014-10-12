class MembershipsController < ApplicationController
  def index
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])
    @memberships = @collaboration.memberships.includes(:user)
  end
  
  def create
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])
    @member = User.find_by_email(params[:member][:email]) || User.invite!(email: params[:member][:email])
    @collaboration.memberships.find_or_create_by(user_id: @member.id)
    redirect_to collaboration_memberships_url(@collaboration)
  end
end
