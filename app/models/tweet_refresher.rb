require_relative 'rubyfriends_app'
require 'twitter'

class TweetRefresher
  attr_reader :tweet_processor
  attr_writer :client
  def initialize(tweet_processor)
    @tweet_processor = tweet_processor
  end

  def refresh
    puts Time.now
    puts "Updating tweets..."
    terms = RUBYFRIENDS_APP.hashtags
    terms.each do |term|
      puts "Search: #{term}"
      client.search(term, include_entities: true, count: '100', result_type: "recent").results.each do |tweet|
        tweet_processor.process(tweet)
      end
    end
    puts "Success!"
    self
  end

  private

    def client
      @client ||= Twitter::Client.new
    end
end