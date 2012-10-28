class Photo < ActiveRecord::Base
  attr_accessible :image_cache, :image, :remote_image_url, :source_url, :user_id, :approved_at
  mount_uploader :image, ImageUploader
  
  validates_presence_of :image
  acts_as_taggable_on :tags
  
  acts_as_votable
  
  def approved?
    self.approved_at.present?
  end
  
end
