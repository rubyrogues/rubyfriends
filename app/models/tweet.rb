class Tweet < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  def self.published
    where(published: true).where("published_at is not null")
  end

end
