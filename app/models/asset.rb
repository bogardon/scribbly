class Asset < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  enum kind: [:photo, :video, :copy]
  has_one :image, as: :imageable, dependent: :destroy

  after_create :create_comment

  accepts_nested_attributes_for :image

  def create_comment
    @comment = Comment.new
    @comment.user = user
    @comment.post = post
    @comment.body = "created something."
    @comment.save
  end
end
