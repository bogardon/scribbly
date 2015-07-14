class CommentsController < ApplicationController
  def new
  end

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      render json: @comment.to_json(include: :user)
    else
      render json: nil, status: 400
    end
  end

  def edit
  end

  def update
  end

  def index
    @post = Post.find_by_id(params[:post_id])
    @comments = @post.comments.includes(:user)
    render json: @comments.to_json(include: :user)
  end

  def show
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :body, :user_id, :post_id)
  end
end
