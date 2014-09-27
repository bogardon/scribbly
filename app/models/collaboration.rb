class Collaboration < ActiveRecord::Base
  has_many :posts
  has_many :memberships
  has_many :users, through: :memberships
  has_many :campaigns
end
