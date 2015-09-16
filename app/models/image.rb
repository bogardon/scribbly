class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  # Paperclip
  has_attached_file :attachment, storage: :s3
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/

end
