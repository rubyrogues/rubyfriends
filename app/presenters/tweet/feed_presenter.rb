class Tweet::FeedPresenter
  attr_accessor :tweet

  def initialize(tweet)
    self.tweet = tweet
  end

  extend Forwardable
  def_delegators  :@tweet, :updated_at, :id, :media_display_url,
                  :tweet_text, :media_url, :to_param

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

end
