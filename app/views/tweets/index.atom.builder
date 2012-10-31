atom_feed root_url: tweets_url do |feed|
  feed.title "#RubyFriends"
  feed.updated @tweets.first.updated_at

  @tweets.each do |tweet|
    feed.entry tweet, url: tweet.media_display_url, id: tweet.tweet_id do |entry|
      entry.url tweet.media_display_url
      entry.title "@#{tweet.username}: #{tweet.tweet_text.truncate 50}"
      entry.content tweet.tweet_text, type: :html
      entry.updated tweet.updated_at.iso8601

      entry.author do |author|
        author.name "@#{tweet.username}"
      end
    end
  end
end
