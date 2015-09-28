class Asset < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_one :image, as: :imageable, dependent: :destroy
  has_many :actions, dependent: :destroy

  after_create :create_upload_action
  after_update :create_approved_action

  accepts_nested_attributes_for :image

  def create_upload_action
    actions.create(
      user: user,
      post: post,
      asset: self,
      body: "#{user.email} uploaded asset #{self.id}"
    )
  end

  def create_approved_action
    return unless approved_at_changed?
    actions.create(
      user: user,
      post: post,
      asset: self,
      body: "#{user.email} approved asset #{self.id}"
    )
  end
end
