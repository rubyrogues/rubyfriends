class Tweet < ActiveRecord::Base
  default_scope order("created_at desc")

  mount_uploader :image, ImageUploader

  def self.published
    where(published: true)
  end
end
