class ContentsController < ApplicationController
  def create
    @post = Post.find_by_id(params[:post_id])
    @content = @post.contents.create
    render json: @content
  end

  def index
    @post = Post.find_by_id(params[:post_id])
    render json: @post.contents
  end

  def destroy
  end
end
