require 'logger'

TWEETSTREAM_LOGGER ||= Logger.new("log/tweetstream_processor_#{Rails.env}.log")
TWEETSTREAM_LOGGER.level = Logger::INFO

require_relative 'tweet_refresher'
require_relative 'tweet_streamer'
require_relative 'tweet_processor'

class RubyfriendsApp
  attr_writer :default_hashtag
  # collaberators/dependencies/setter injectors
  attr_writer :entry_initializer, :tweet_refresher,
              :tweet_processor, :tweet_streamer

  def title
    'RubyFriends.com'
  end

  def subtitle
    'Community starts with friendship!'
  end

  def default_hashtag
    @default_hashtag ||= "RubyFriends"
  end

  def hashtags
    result = [default_hashtag]
    result |= [default_hashtag.singularize]
  end

  def initialize(entry_fetcher = Tweet.public_method(:published))
    @entry_fetcher = entry_fetcher
  end

  # commands
  def new_entry(*args)
    entry_initializer.call(*args).tap do |entry|
      entry.app = self
    end
  end

  def add_entry(entry)
    entry.save
  end

  def refresh_tweets
    tweet_refresher.(tweet_processor.(self)).refresh
  end

  def persist_tweetstream
    tweet_streamer.(tweet_processor.(self)).stream
  end

  # queries
  def entries
    fetch_entries
  end

  # move to exhibit/presenter
  def entries_count
    entries.count
  end
  # inconsistent language so its been aliased for now
  alias tweets_count entries_count

  # TODO - move me to presenter/exhibit or put in controller and don't test
  # its a library, it doesn't need it. Currently tested in integration spec
  def paginated_entries(params)
    entries.page(params).per(20)
  end

  private

    def entry_initializer
      @entry_initializer ||= Tweet.public_method(:new)
    end

    def tweet_refresher
      @tweet_refresher ||= TweetRefresher.public_method(:new)
    end

    def tweet_processor
      @tweet_processor ||= TweetProcessor.public_method(:new)
    end

    def tweet_streamer
      @tweet_streamer ||= TweetStreamer.public_method(:new)
    end

    def fetch_entries
      @entry_fetcher.()
    end
end