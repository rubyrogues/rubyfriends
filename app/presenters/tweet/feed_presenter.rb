class Tweet::FeedPresenter
  attr_accessor :tweet

  def initialize(tweet)
    self.tweet = tweet
  end

  def self.model_name
    Tweet.model_name
  end

  def author
    username
  end

  def content
    <<-HTML.gsub /^ {6}/, ''
      #{tweet_text}
      <br />
      <img src="#{media_url}" />
    HTML
  end

  def title
    "#{username}: #{tweet_text}".truncate 50
  end

  def url
    media_display_url
  end

  def username
    "@#{tweet.username}"
  end

  private

  def method_missing(*args)
    tweet.send *args
  end
end
