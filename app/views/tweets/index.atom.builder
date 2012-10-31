@tweets.map! { |tweet| Tweet::FeedPresenter.new tweet }

atom_feed root_url: tweets_url do |feed|
  feed.title "#RubyFriends"
  feed.updated @tweets.first.updated_at

  @tweets.each do |tweet|
    feed.entry tweet do |entry|
      entry.url tweet.url
      entry.title tweet.title
      entry.content tweet.content, type: :html
      entry.updated tweet.updated_at.iso8601

      entry.author do |author|
        author.name tweet.author
      end
    end
  end
end
