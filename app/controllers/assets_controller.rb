class AssetsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    @post = Post.find_by_id(params[:post_id])
    @asset = @post.assets.new(asset_params)
    attachment = params[:asset][:image][:attachment]
    image = Image.new
    image.attachment = attachment.tempfile
    @asset.image = image
    @asset.user = current_user
    if @asset.save
      render json: @asset
    else
      render json: nil, status: 400
    end

  end

  def asset_params
    params.require(:asset).permit(:id)
  end
end
