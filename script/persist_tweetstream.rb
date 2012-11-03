ENV['RAILS_ENV'] ||= 'development'
require_relative '../config/environment.rb'

require 'daemons'

# A daemonized TweetStream client that will allow you to
# create backgroundable scripts for application specific
# processes. For instance, if you create a script called
# <tt>tracker.rb</tt> and fill it with this:



require 'rubygems'
# require 'tweetstream'
# require 'yaml'
# require 'active_record'

# databases = YAML.load_file("config/database.yml")
# ActiveRecord::Base.establish_connection(databases['test'])

# require_relative '../app/models/rubyfriends_app'
# require_relative '../config/initializers/rubyfriends_app'
# require 'carrierwave'
# require_relative '../app/models/tweet'


ENV['consumer_key'] = 'ZLOlbk68CMwRHN1FL8w'
ENV['consumer_secret'] = 'XuAdeN14I447S1Z08isFvVG8DusK2TXVUMkeVe09g'
ENV['oauth_token'] = '47131629-WqdrhXr3h40MLpKBS0oBfuxiClviJwmE3CsTZjL7G'
ENV['oauth_token_secret'] = 'awVprFLKPtPCewCVLYZqwcZNgb3RkvVWp520VbFNKSU'

TweetStream.configure do |config|
  config.consumer_key       = ENV['consumer_key']
  config.consumer_secret    = ENV['consumer_secret']
  config.oauth_token        = ENV['oauth_token']
  config.oauth_token_secret = ENV['oauth_token_secret']
  config.auth_method        = :oauth
end

TweetStream::Daemon.new('rubyfriends_app').track(*RUBYFRIENDS_APP.hashtags) do |status|
  TweetProcessor.new(RUBYFRIENDS_APP).process(tweet)
end
#
# And then you call this from the shell:
#
#     ruby persist_tweetstream.rb start