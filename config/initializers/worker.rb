module RubyFriends
  module Worker
    extend self

    def instance
      @instance ||= Thread.new do
        loop do
          RUBYFRIENDS_APP.refresh_tweets
          puts "Sleeping for 60 seconds..."
          sleep 60
        end
      end
    end

    def start
      instance
    end
  end
end

RubyFriends::Worker.start
