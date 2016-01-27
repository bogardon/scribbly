class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  has_many :memberships
  has_many :collaborations, through: :memberships
  has_many :campaigns, through: :collaborations
  has_many :posts
  has_many :comments

  has_one :avatar, as: :imageable, dependent: :destroy
end
