class Asset < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  enum kind: [:photo, :video, :copy]
  has_one :image, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :image
end
