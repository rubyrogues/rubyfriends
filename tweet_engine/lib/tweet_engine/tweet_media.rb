require_relative 'tweet_media_extractor'
class TweetMedia
  attr_reader :media_url, :media_display_url

  def initialize(tweet)
    set_media_url(tweet.media, tweet.urls)
  end

  def has_media?
    !!media_url
  end
  private

  def set_media_url(tweet_media, tweet_urls)
    if tweet_media && tweet_media.empty?
      media_from_tweet_urls(tweet_urls)
    else
      media_from_tweet_media(tweet_media)
    end
  end

  def media_from_tweet_urls(tweet_urls)
    tweet_urls.each do |expanded_url|
      if TweetMediaExtractor.is_image?(expanded_url)
        @media_display_url = expanded_url
        @media_url = TweetMediaExtractor.get_image_url(expanded_url)
      end
    end
  end

  def media_from_tweet_media(tweet_media)
    @media_display_url = tweet_media.first.display_url
    @media_url = tweet_media.first.media_url
  end

end
