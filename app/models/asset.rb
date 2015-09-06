class Asset < ActiveRecord::Base
  enum type: [:photo, :video, :copy]
  has_one :image, as: :imageable, dependent: :destroy
end
