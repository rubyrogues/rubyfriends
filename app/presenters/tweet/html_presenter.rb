class Tweet::HtmlPresenter
  attr_accessor :tweet

  def initialize(tweet)
    self.tweet = tweet
  end

  def self.model_name
    Tweet.model_name
  end

  # escape unsafe html and linkify for display
  def text
    buffer = ActiveSupport::SafeBuffer.new
    buffer << tweet.tweet_text
    buffer = TweetHelper.tweet_display_text(buffer)
    buffer
  end

  def url
    TweetHelper.twitter_status_url(tweet.username, tweet.tweet_id)
  end

  def username
    "@#{tweet.username}"
  end

  private

  def method_missing(*args)
    tweet.send *args
  end

end
