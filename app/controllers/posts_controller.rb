class PostsController < ApplicationController
  def new
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])
    @post = Post.new
    @comment = @post.comments.build
    @content = @post.contents.build
  end

  def index
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])

    date = params[:date].to_datetime
    week = date.all_week(:sunday)

    @weekly_posts = @collaboration.posts.during(week)

    @day_posts_pairs = week.map do |d|
      p = @weekly_posts.select do |p|
        p.scheduled_at.between?(d, d + 1)
      end.sort(&:scheduled_at)
      [d, p]
    end

    render json: @day_posts_pairs
  end

  def create
    @collaboration = Collaboration.find_by_id(params[:collaboration_id])
    @post = Post.new(post_params)
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
