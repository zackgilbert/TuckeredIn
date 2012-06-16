class Photo < ActiveRecord::Base
  attr_accessible :image, :remote_image_url, :source_url, :user_id, :approved_at
  mount_uploader :image, ImageUploader
  
  validates_presence_of :image
  
end
