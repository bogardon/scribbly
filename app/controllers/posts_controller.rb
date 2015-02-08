class PostsController < ApplicationController
  def new
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])
    @post = Post.new
    @comment = @post.comments.build
    @content = @post.contents.build
  end

  def index
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])

    start_date = params[:start].to_datetime
    end_date = params[:end].to_datetime

    @posts = @collaboration.posts.during(start_date..end_date)

    render json: @posts
  end

  def create
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])
    @post = Post.new(post_params)
    date_params = params[:scheduled_at]
    scheduled_at = DateTime.new(
      date_params[:year].to_i,
      date_params[:month].to_i,
      date_params[:date].to_i,
      date_params[:hour].to_i,
      date_params[:minute].to_i
    ).change(offset: (-date_params[:offset].to_f/(24*60*60)))
    @post.scheduled_at = scheduled_at
    if @post.save
      redirect_to collaboration_url(@collaboration)
    else
      flash[:notice] = @post.errors
      redirect_to new_collaboration_post_url
    end
  end

  def edit
  end

  def update
  end

  def show
    @post = Post.includes(:contents, comments: :user).find_by_id(params[:id])

    @comment = Comment.new
    @content = Content.new
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :collaboration_id, :campaign_id, :name, :scheduled_at, :time_zone,
      :comments_attributes => [:id, :body, :user_id, :post_id],
      :contents_attributes => [:id, :body, :user_id, :post_id, :media])
  end
end
