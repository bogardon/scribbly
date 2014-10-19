class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    
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

  def post_params
    params.require(:post).permit(:user_id, :campaign_id, :description)
  end
end
