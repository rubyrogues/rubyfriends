require_relative '../spec_helper_lite'
require_relative '../../app/models/tweet_processor'



describe TweetProcessor do
  let(:app_dbl) { fire_double('RubyfriendsApp') }
  subject(:tweet_processor) { described_class.new(app_dbl) }

  describe '#process' do
    it "sends #new_entry to the app along with tweet's persistable attrs" do
      tweet_dbl = double('tweet', id: 'TWEET_ID').as_null_object

      app_dbl.should_receive(:new_entry).ordered
        .with(hash_including(tweet_id: 'TWEET_ID')) { tweet_dbl }

      tweet_dbl.should_receive(:publish).ordered

      tweet_processor.process(tweet_dbl)
    end
  end
end

