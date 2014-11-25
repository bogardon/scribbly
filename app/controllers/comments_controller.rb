class CommentsController < ApplicationController
  def new
  end

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
    else
      flash[:notice] = @comment.errors
    end
    
    respond_to do |format|
      format.js
    end
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

  def comment_params
    params.require(:comment).permit(:id, :body, :user_id, :post_id)
  end
end
