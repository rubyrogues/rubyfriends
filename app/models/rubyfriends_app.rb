require_relative 'tweet'
require_relative 'hug_app_code'

class RubyfriendsApp
  attr_writer :title, :subtitle, :entry_source, :default_hashtag

  def title
    @title ||= 'RubyFriends.com'
  end

  def subtitle
    @subtitle ||= 'Community starts with friendship!'
  end

  def default_hashtag
    @default_hashtag ||= "RubyFriends"
  end

  def initialize(entry_fetcher = Tweet.public_method(:published))
    @entry_fetcher = entry_fetcher
  end

  def new_entry(*args)
    entry_source.call(*args).tap do |entry|
      entry.app = self
    end
  end

  def add_entry(entry)
    entry.save
  end

  def hashtags
    result = [default_hashtag]
    result |= [default_hashtag.singularize]
  end

  def entries
    fetch_entries
  end

  def paginated_entries(params)
    entries.page(params).per(20)
  end

  def refresh_tweets
    HugAppScript.update_tweets
  end

  def tweets_count
    entries.count
  end

  private

    def entry_source
      @entry_source ||= Tweet.public_method(:new)
    end

    def fetch_entries
      @entry_fetcher.()
    end
end