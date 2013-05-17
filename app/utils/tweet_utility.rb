module TweetUtility
  extend self


  def refresh_tweets
    puts Time.now
    puts "Updating tweets..."
    create_or_skip(
      TWEET_SEARCHER.recent_tweets
    )
    puts "Success!"
  end

  def create_or_skip(tweet_statuses)
    new_tweets(tweet_statuses).each do |tweet_status|
      create_tweet(tweet_status)
    end
  end

  private

  def new_tweets(tweet_statuses)
    if tweets_must_have_media?
      tweets_with_media(tweet_statuses)
    else
      tweet_statuses
    end.select do |tweet_status|
      not_a_retweet(tweet_status) &&
        tweet_media_not_saved(tweet_status) &&
        tweet_already_saved(tweet_status)
    end
  end

  def tweets_with_media(tweet_statuses)
    Array(tweet_statuses).select {|tweet_status| tweet_status.has_media? }
  end

  def tweet_media_not_saved(tweet_status)
    if tweet_status.media_url
      Tweet.where(media_url: tweet_status.media_url).count('id') == 0
    else
      true
    end
  end

  def not_a_retweet(tweet_status)
    !tweet_status.retweet? ||
       !(tweet_status.tweet_text =~ /\ART/o)
  end

  def tweet_already_saved(tweet_status)
    Tweet.where(:tweet_id => tweet_status.tweet_id).count('tweet_id') == 0
  end

  def create_tweet(tweet_status)
    tweet = populate_new_tweet(tweet_status)
    # TODO failure scenario?
    if tweet.save
      puts "Created tweet @#{tweet.username}: #{tweet.tweet_text}"

      if ENV['retweet'] =~ /true/io
        Twitter.retweet tweet.id
        puts "Retweeted tweet @#{tweet.username}: #{tweet.tweet_text}"
      end
    end
  end

  def populate_new_tweet(tweet_status)
    tweet = Tweet.new
    field_mappings = {
      username: :username=,
      tweet_id: :tweet_id=,
      tweet_text: :tweet_text=,
      retweet_count: :retweet_count=,
      published_at: :published_at=,
      # carrierwave remote_fieldname_url will download image from url, convert
      # it and resave it
      media_url: :remote_image_url=
    }
    field_mappings.each do |status_field, tweet_field|
      data = tweet_status.public_send(status_field)
      tweet.public_send(tweet_field, data)
    end
    tweet.published = true
    tweet
  end

  def allow_tweets_without_media?
    ENV['allow_tweets_without_media'] == 'true'
  end

  def tweets_must_have_media?
    !allow_tweets_without_media?
  end

end
