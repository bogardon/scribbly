class Post < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user
  has_many :comments
  has_many :contents
end
