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

end
