class Friend < ActiveRecord::Base
  attr_accessible :tweet_id
  attr_accessible :tweet_text
  attr_accessible :username
  attr_accessible :media_url
  attr_accessible :media_display_url
  attr_accessible :thumb_file_name
  attr_accessible :retweet_count
  attr_accessible :published_at
  attr_accessible :published


end
