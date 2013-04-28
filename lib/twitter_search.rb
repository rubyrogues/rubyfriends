require 'twitter'
require_relative 'tweet_status'
class TwitterSearch

  attr_reader :default_hashtag
  attr_reader :search_result_type
  def initialize(hashtags, result_type=nil)
    @hashtags = Array(hashtags)
    @default_hashtag = @hashtags.first
    @search_result_type = result_type
  end

  def recent_tweets
    @hashtags.map {|hashtag| search_recent_statuses(hashtag) }.flatten
  end

  def search_result_type=(result_type)
    if valid_result_types.include?(result_type)
      @search_result_type = result_type
    else
      @search_result_type = default_search_result_type
    end
  end

  private

  def default_search_result_type
    'recent'
  end

  def valid_result_types
    %w(recent popular mixed)
  end

  def search_recent_statuses(term)
    search_recent(term).statuses.map do |status|
      TweetStatus.new(status)
    end
  end

  # http://rdoc.info/gems/twitter/Twitter/API/Search
  # raises Twitter::Error::Unauthorized
  # returns Twitter::SearchResults
  # http://rdoc.info/gems/twitter/Twitter/SearchResults
  def search_recent(term)
    Twitter.search(term, include_entities: true, count: 50, result_type: search_result_type)
  end

end
