require 'daemons'
require_relative '../config/environment.rb'

# A daemonized TweetStream client that will allow you to
# create backgroundable scripts for application specific
# processes. For instance, if you create a script called
# <tt>tracker.rb</tt> and fill it with this:

TweetStream::Daemon.new('rubyfriends_app').track(*RUBYFRIENDS_APP.hashtags) do |tweet|
  TweetProcessor.new(RUBYFRIENDS_APP).process(tweet)
end
#
# And then you call this from the shell:
#
#     ruby persist_tweetstream.rb start