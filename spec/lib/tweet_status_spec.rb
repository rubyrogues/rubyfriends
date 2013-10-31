require 'spec_helper'

describe TweetStatus do

  it 'has a tweet_text' do
    tweet = double('tweet', :text => 'hi')
    tweet_status = TweetStatus.new(tweet)
    expect(tweet_status.tweet_text).to eq('hi')
  end

end
