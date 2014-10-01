class Campaign < ActiveRecord::Base
  belongs_to :collaboration
  has_many :posts
end
