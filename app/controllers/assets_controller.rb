class AssetsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    @post = Post.find_by_id(params[:post_id])
    @asset = @post.assets.create(asset_params)
    @asset.user = current_user
    render json: @asset
  end

  def asset_params
    params.require(:asset).permit(:id, image_attributes: [:attachment])
  end
end
