class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :invitable
         
  # Paperclip
  has_attached_file :avatar,
                    :styles => { :medium => "300x300#", :thumb => "100x100#" },
                    :default_url => "/images/avatar_placeholder.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :memberships
  has_many :collaborations, through: :memberships
  has_many :campaigns, through: :collaborations
  has_many :posts
  has_many :comments
end
