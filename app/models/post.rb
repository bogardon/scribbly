class Post < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user
  has_many :comments
  has_many :contents

  accepts_nested_attributes_for :comments  
  accepts_nested_attributes_for :contents

end
