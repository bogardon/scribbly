class Asset < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_one :image, as: :imageable, dependent: :destroy

  after_create :create_comment

  accepts_nested_attributes_for :image

  def create_comment
  end
end
