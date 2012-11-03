require_relative 'rubyfriends_app'

class TweetProcessor
  attr_reader :app
  def initialize(app)
    @app = app
  end

  def process(tweet)
    TWEETSTREAM_LOGGER.info(tweet)

    new_tweet = app.new_entry(attrs_hash_for(tweet))
    new_tweet.publish

    self
  end

  def attrs_hash_for(tweet)
    if tweet.media && tweet.media.empty?
      tweet.expanded_urls.each do |expanded_url|
        if is_image?(expanded_url)
          @media_url = get_image_url(expanded_url)
          @media_display_url = expanded_url
        end
      end
    else
      @media_url = tweet.media.first.media_url
      @media_display_url = tweet.media.first.display_url
    end

    new_tweet_attributes = OpenStruct.new.tap do |t|
      t.tweet_id          = tweet.id
      t.tweet_text        = tweet.full_text
      t.username          = tweet.from_user
      t.media_url         = @media_url
      t.media_display_url = @media_display_url
      t.retweet_count     = tweet.retweet_count
      t.remote_image_url  = @media_url
    end.marshal_dump
  end
end


# FIXME - add this back in!
# puts "Created tweet @#{new_tweet.username}: #{new_tweet.tweet_text}"
#
# if ENV['oauth_token']
#   Twitter.retweet tweet.id
#   puts "Retweeted tweet @#{new_tweet.username}: #{new_tweet.tweet_text}"
# end