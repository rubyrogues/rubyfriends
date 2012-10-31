class Tweet::HtmlPresenter
  attr_accessor :tweet

  def initialize(tweet)
    self.tweet = tweet
  end

  def self.model_name
    Tweet.model_name
  end

  def date
    published_at.strftime '%b %d, %Y'
  end

  def url
    tweet.media_display_url
  end

  def username
    "@#{tweet.username}"
  end

  private

  def method_missing(*args)
    tweet.send *args
  end
end
