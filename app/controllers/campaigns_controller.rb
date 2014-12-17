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
  end

  def show
    @campaign = Campaign.find_by_id(params[:id])
    @posts = @campaign.posts
    @weekly_posts = Date.today.all_week(:sunday).map do |d|
      p = @posts.select do |p|
        p.scheduled_at.between?(d, d+1)
      end
      [d, p]
    end
  end

  def destroy
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :description, :collaboration_id)
  end
end
