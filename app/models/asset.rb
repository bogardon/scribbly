class Asset < ActiveRecord::Base
  belongs_to :post
  has_one :image, as: :imageable, dependent: :destroy
end
