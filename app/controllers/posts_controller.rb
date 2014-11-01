class PostsController < ApplicationController
  def new
    @campaign = Campaign.find_by_id(params[:campaign_id])
    @post = Post.new
    @comment = @post.comments.build
    # @content = @post.contents.build
  end

  def create
    @campaign = Campaign.find_by_id(params[:campaign_id])
    @post = Post.new(post_params)
    if @post.save
      redirect_to campaign_posts_url
    else
      flash[:notice] = @post.errors
      redirect_to new_campaign_post_url
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
