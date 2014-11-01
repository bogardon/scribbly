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
      redirect_to campaign_url(@campaign)
    else
      flash[:notice] = @post.errors
      redirect_to new_campaign_post_url
    end
  end

  def edit
  end

  def update
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :campaign_id, :name,
      :comments_attributes => [:id, :body, :user_id, :post_id],
      :contents_attributes => [:id, :body, :post_id])
  end
end
