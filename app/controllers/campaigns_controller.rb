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
      redirect_to collaboration_url(@collaboration)
    end
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def destroy
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :description, :collaboration_id)
  end
end
