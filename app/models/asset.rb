class Asset < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_one :image, as: :imageable, dependent: :destroy
  has_many :actions

  after_create :create_action

  accepts_nested_attributes_for :image

  def create_action
    actions.create(
      user: user,
      post: post,
      body: "#{user.email} uploaded an asset."
    )
  end
end
