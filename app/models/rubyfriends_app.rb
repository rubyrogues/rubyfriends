require_relative 'tweet'
require_relative 'hug_app_code'

class RubyfriendsApp
  attr_accessor :default_hashtag, :title, :subtitle

  def hashtags
    [default_hashtag]
  end

  def tweets
    Tweet.published
  end

  def paginated_tweets(params)
    tweets.page(params).per(20)
  end

  def refresh_tweets
    HugAppScript.update_tweets
  end

  def tweets_count
    tweets.count
  end
end