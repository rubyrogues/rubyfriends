require_relative '../spec_helper_lite'
require_relative '../../app/models/tweet_streamer'

describe TweetStreamer do
  let(:tweet_processor_dbl) { fire_double('TweetProcessor') }
  subject(:tweet_streamer) { described_class.new(tweet_processor_dbl) }

  describe '#stream' do
    it 'sends process to tweet_processor with a tweet any number of times' do
      rubyfriends_app = fire_double('RubyfriendsApp', hashtags: ['RubyFriends'])
      stub_const("RUBYFRIENDS_APP", rubyfriends_app)

      tweet_dbl = double('tweet')
      client_dbl = fire_double('TweetStream::Client').tap do |client_dbl|
        client_dbl.stub(:userstream)
        client_dbl.stub(:track).and_yield(tweet_dbl, client_dbl)
      end.as_null_object
      tweet_streamer.client = client_dbl

      tweet_processor_dbl.should_receive(:process).with(tweet_dbl)

      tweet_streamer.stream
    end
  end

end