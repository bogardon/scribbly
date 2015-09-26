class FeedItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :asset
end
