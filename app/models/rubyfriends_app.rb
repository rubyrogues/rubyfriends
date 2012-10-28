require_relative 'tweet'
require_relative 'hug_app_code'

class RubyfriendsApp
  attr_accessor :default_hashtag, :title, :subtitle, :current_conference_hashtag

  def hashtags
    [default_hashtag, current_conference_hashtag]
  end

  def tweets
    Tweet.all
  end

  def refresh_tweets
    HugAppScript.update_tweets
  end

  def tweets_count
    tweets.count
  end
end