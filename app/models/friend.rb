class Friend < ActiveRecord::Base

  def self.published
    where(published: true)
  end

  mount_uploader :image, ImageUploader

end
