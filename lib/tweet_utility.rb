module TweetUtility
  extend self


  def self.refresh_tweets
    puts Time.now
    puts "Updating tweets..."
    Tweet.create_or_skip(
      TWEET_SEARCHER.recent_tweets
    )
    puts "Success!"
  end

  def twitter_url(term = TWEET_SEARCHER.default_hashtag)
    "https://twitter.com/#!/#{term}"
  end

  def total_tweets
    tweets.count
  end

  def paginated_tweets(params = params[:page])
    tweets.page(params).per(20)
  end

  private

  def tweets
    Tweet.published
  end

end
