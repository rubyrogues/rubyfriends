class Tweet::HtmlPresenter
  attr_accessor :tweet

  def initialize(tweet)
    self.tweet = tweet
  end

  def self.model_name
    Tweet.model_name
  end

  def text
    buffer = ActiveSupport::SafeBuffer.new
    buffer << tweet.tweet_text
    link_urls(buffer)
    link_hashtags(buffer)
    link_usernames(buffer)
    buffer
  end

  def url
    TweetHelper.twitter_status_url(tweet.username, tweet.tweet_id)
  end

  def username
    "@#{tweet.username}"
  end

  private

  def link_urls(text)
    text.gsub! /(https?[^\s]+)/o,
                      %q(<a href="\\1" target="_blank">\\1</a>)
  end

  def link_hashtags(text)
    text.gsub! /#(\w+)/, '<a href="http://twitter.com/search?q=%23\\1">#\\1</a>'
  end

  def link_usernames(text)
    text.gsub! /@(\w+)/, '<a href="http://twitter.com/\\1">@\\1</a>'
  end

  def method_missing(*args)
    tweet.send *args
  end

end
