require_relative '../spec_helper_lite'
require_relative '../../app/models/tweet_refresher'

describe TweetRefresher do
  let(:tweet_processor_dbl) { fire_double('TweetProcessor') }
  subject(:tweet_refresher) { described_class.new(tweet_processor_dbl) }

  describe '#refresh' do
    it 'sends refresh to tweet_processor with a tweet any number of times' do
      rubyfriends_app = fire_double('RubyfriendsApp', hashtags: ['RubyFriends'])
      stub_const("RUBYFRIENDS_APP", rubyfriends_app)

      tweet_dbl = double('tweet')
      client_dbl = fire_double('Twitter::Client').tap do |client_dbl|
        client_dbl.stub_chain(:search, :results, :each).and_yield(tweet_dbl)
      end.as_null_object
      tweet_refresher.client = client_dbl

      tweet_processor_dbl.should_receive(:process).with(tweet_dbl)

      tweet_refresher.refresh
    end
  end
end