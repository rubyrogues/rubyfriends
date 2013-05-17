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

    # make links anchors
    buffer.gsub! /(https?[^\s]+)/o,
                      %q(<a href="\\1" target="_blank">\\1</a>)
    # link hashtags
    buffer.gsub! /#(\w+)/, '<a href="http://twitter.com/search?q=%23\\1">#\\1</a>'
    # link users
    buffer.gsub! /@(\w+)/, '<a href="http://twitter.com/\\1">@\\1</a>'

    buffer
  end

  def url
    buffer = tweet.media_display_url
    return unless buffer
    buffer = "http://#{buffer}" unless buffer.start_with? "http://"
    buffer
  end

  def username
    "@#{tweet.username}"
  end

  private

  def method_missing(*args)
    tweet.send *args
  end
end
