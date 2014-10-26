class PostsController < ApplicationController
  def new
    @campaign = Campaign.find_by_id(params[:campaign_id])
    @post = @campaign.posts.build
    @comment = @post.comments.build
    # @content = @post.contents.build
  end

  def create
    # binding.pry
    @campaign = Campaign.find_by_id(params[:campaign_id])
    @post = current_user.posts.new(post_params)
    @post.campaign_id = @campaign.id
    # @comment = @post.comments.build(post_params)
    # @content = @post.contents.build(post_params)

    if @post.save
      redirect_to campaign_posts_url
    else
      redirect_to campaign_posts_url      
    end
  end

  def edit
  end

  def update
  end

  def index
    @campaign = Campaign.find_by_id(params[:campaign_id])
    @posts = @campaign.posts
  end

  def show
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :campaign_id, :description,
      :comments_attributes => [:id, :description, :user_id, :post_id],
      :contents_attributes => [:id, :body, :post_id])
  end
end
