class CampaignsController < ApplicationController
  def new
    @collaboration = Collaboration.find(params[:collaboration_id])
    @campaign = @collaboration.campaigns.build
  end

  def create
    @collaboration = Collaboration.find(params[:collaboration_id])

    @campaign = @collaboration.campaigns.build(campaign_params)

    if @campaign.save
      redirect_to collaboration_url(@collaboration)
    else
      flash[:notice] = @campaign.errors
      redirect_to new_collaboration_campaign(@collaboration)
    end
  end

  def edit
  end

  def update
  end

  def index
    @collaboration = Collaboration.find(params[:collaboration_id])
    @campaigns = @collaboration.campaigns
    render json: @campaigns
  end

  def show
    @campaign = Campaign.find_by_id(params[:id])
  end

  def destroy
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :description, :collaboration_id)
  end
end
