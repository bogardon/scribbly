class ContentsController < ApplicationController
  def new
  end

  def create
    @content = Content.new(content_params)
    @content.save
    redirect_to post_url(params[:post_id])
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
  end

  def destroy
  end

  private

  def content_params
    params.require(:content).permit(:id, :post_id, :user_id, :media)
  end
end
