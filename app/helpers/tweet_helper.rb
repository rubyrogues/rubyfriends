module TweetHelper
  extend self

  def twitter_url(term = TWEET_SEARCHER.default_hashtag)
    "https://twitter.com/#!/#{term}"
  end

  def twitter_status_url(username, tweet_id)
    "https://twitter.com/#{username}/status/#{tweet_id}"
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
