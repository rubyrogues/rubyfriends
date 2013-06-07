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

  def tweet_display_text(text)
    text = link_urls(text)
    text = link_hashtags(text)
    text = link_usernames(text)
    text
  end

  def link_urls(text)
    text.gsub(/(https?[^\s]+)/o,
                      %q(<a href="\\1" target="_blank">\\1</a>)
             )
  end

  def link_hashtags(text)
    text.gsub(/#(\w+)/,
              '<a href="http://twitter.com/search?q=%23\\1">#\\1</a>'
             )
  end

  def link_usernames(text)
    text.gsub(/@(\w+)/,
              '<a href="http://twitter.com/\\1">@\\1</a>'
             )
  end

  private

  def tweets
    Tweet.published
  end

end
