class Asset < ActiveRecord::Base
  belongs_to :content
  has_one :image, as: :imageable, dependent: :destroy
end
