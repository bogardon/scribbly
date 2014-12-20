class Post < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :contents, dependent: :destroy

  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :contents

  scope :during, ->(time_frame) {
    where scheduled_at: time_frame
  }

  attr_accessor :time_zone
  before_save :use_selected_time_zone

  def use_selected_time_zone
    time_zone = ActiveSupport::TimeZone.new self.time_zone
    self.scheduled_at -= time_zone.utc_offset
  end
end
