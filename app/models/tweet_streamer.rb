require_relative 'rubyfriends_app'

class TweetStreamer
  attr_reader :tweet_processor
  attr_writer :client
  def initialize(tweet_processor)
    @tweet_processor = tweet_processor
  end

  def stream
    puts "Waking up to grab some tweets"
    puts "Listening... #{Time.now}"

    client.on_error do |message|
      puts "Error: #{Time.now}"
      puts message
      puts "END of Error"
    end

    client.track(*RUBYFRIENDS_APP.hashtags) do |tweet, client|
      tweet_processor.process(tweet)
    end

    client.userstream
    self
  end

  private

    def client
      @client ||= TweetStream::Client.new
    end

end