class Content < ActiveRecord::Base
  belongs_to :post
  has_many :assets, dependent: :destroy
end
