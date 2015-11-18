class AssetsController < ApplicationController
  def index
    @content = Content.find_by_id(params[:content_id])
    @assets = @content.assets
    render json: @assets.to_json(include: {image: {methods: :url}})
  end

  def create
    @content = Content.find_by_id(params[:asset][:content_id])
    @asset = @content.assets.new(asset_params)
    attachment = params[:asset][:image][:attachment]
    image = Image.new
    image.attachment = attachment.tempfile
    @asset.image = image
    if @asset.save
      render json: @asset.to_json(include: {image: {methods: :url}})
    else
      render json: nil, status: 400
    end
  end

  def update
    @asset = Asset.find(params[:id])
    @asset.update(asset_params)
    if @asset.save
      render json: @asset.to_json(include: {image: {methods: :url}})
    else
      render json: nil, status: 400
    end
  end

  def asset_params
    params.require(:asset).permit(:id, :approved_at)
  end
end
