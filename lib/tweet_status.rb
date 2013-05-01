require_relative 'tweet_media'
require 'forwardable'

class TweetStatus
  extend Forwardable

  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  def_delegators :tweet_media, :has_media?, :media_url, :media_display_url

  def username
    tweet.from_user.nil? ? tweet.user.screen_name : tweet.from_user
  end

  def tweet_text
    tweet.text
  end

  def tweet_id
    tweet.id
  end

  def retweet_count
    tweet.retweet_count
  end

  def published_at
    tweet.created_at
  end

  def published
    true
  end

  def retweet?
    tweet.retweet?
  end

  private

  def tweet_media
    @tweet_media ||= TweetMedia.new(tweet)
  end

end
