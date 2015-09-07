class Asset < ActiveRecord::Base
  belongs_to :post
  enum type: [:photo, :video, :copy]
  has_one :image, as: :imageable, dependent: :destroy
end
