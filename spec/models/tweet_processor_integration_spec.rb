require 'spec_helper'

describe TweetProcessor do
  let(:app) { RUBYFRIENDS_APP }
  let(:tweet_processor) { described_class.new(app) }

  it "BUG - it errors with undefined method 'media'" do
    tweet = Twitter::Tweet.new(rb_fixture('second_tweet_working'))
    tweet_processor.process(tweet)

    app.entries.first.should eq ''
  end

  it 'BUG - it errors for broken_expanded_urls_error.rb' do
    tweet = Twitter::Tweet.new(rb_fixture('second_tweet_working'))
    tweet_processor.process(tweet)

    app.entries.first.should eq ''
  end




end