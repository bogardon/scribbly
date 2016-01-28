class Post < ActiveRecord::Base
  belongs_to :collaboration
  belongs_to :user
  belongs_to :platform
  has_many :feed_items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  enum status: [ :draft, :pending, :approved ]

  accepts_nested_attributes_for :feed_items
  accepts_nested_attributes_for :assets

  scope :during, ->(time_frame) {
    where scheduled_at: time_frame
  }

  attr_accessor :time_zone
  before_save :use_selected_time_zone

  def use_selected_time_zone
    return unless self.time_zone
    time_zone = ActiveSupport::TimeZone.new self.time_zone
    self.scheduled_at -= time_zone.utc_offset
  end
end
