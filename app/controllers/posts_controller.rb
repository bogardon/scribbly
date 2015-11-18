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
    @post.user_id = current_user.id
    scheduled_at = DateTime.parse(params[:scheduled_at]).change(offset: (-params[:timezone_offset].to_f/(24*60*60)))
    @post.scheduled_at = scheduled_at
    @post.save
    render json: @post
  end

  def edit
  end

  def update
  end

  def show
    @post = Post.includes(contents: {assets: :image}, feed_items: :user).find_by_id(params[:id])
    if @post
      render json: @post.to_json(include: {
        contents: {assets: {include: {image: {methods: :url}}}},
        feed_items: {include: :user}
      })
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :collaboration_id, :campaign_id, :title, :description, :scheduled_at, :time_zone,
      :comments_attributes => [:id, :body, :user_id, :post_id],
      :contents_attributes => [:id, :body, :user_id, :post_id, :media])
  end
end
