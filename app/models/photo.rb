class Photo < ActiveRecord::Base
  attr_accessible :image, :source_url
  mount_uploader :image, ImageUploader
  
end
