class Tweet < ActiveRecord::Base

  default_scope order("published_at desc")

  attr_accessor :app

  def publish(clock = DateTime)
    self.published_at ||= clock.now
    self.published = true
    app.add_entry(self)
  end



  MOUNT_IMAGE_UPLOADER ||=
    ->{ mount_uploader :image, ImageUploader }.call

  def self.published
    where(published: true).where("published_at is not null")
  end
end
