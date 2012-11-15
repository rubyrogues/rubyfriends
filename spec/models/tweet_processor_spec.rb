require_relative '../spec_helper_lite'
require_relative '../../app/models/tweet_processor'

require 'twitter'

describe TweetProcessor do
  let(:app_dbl) { fire_double('RubyfriendsApp') }
  let(:tweet_processor) { described_class.new(app_dbl) }

  describe '#process' do
    it "sends #new_entry to the app along with tweet's persistable attrs" do
      tweet_dbl = double('tweet', id: 'TWEET_ID').as_null_object

      app_dbl.should_receive(:new_entry).ordered
        .with(hash_including(tweet_id: 'TWEET_ID')) { tweet_dbl }

      tweet_dbl.should_receive(:publish).ordered

      tweet_processor.process(tweet_dbl)
    end

  end

  describe '#new_tweet_attrs', 'attrs from tweet matched to db columns' do
    let(:tweet_dbl) { Twitter::Tweet.new(rb_fixture('normative_tweet')) }
    subject(:attrs) { tweet_processor.new_tweet_attrs(tweet_dbl) }
    its([:tweet_id]) { should eq 264511910832140288 }
    its([:tweet_text]) { should eq "RT @karledurante: new east coast  #rubyfriends @akeem http://t.co/JE84wpTq" }
    its([:username]) { should eq "RubyFriends" }
    its([:media_url]) { should eq "http://p.twimg.com/A6u7_sdCUAAQXmK.jpg" }
    its([:media_display_url]) { should eq "pic.twitter.com/JE84wpTq" }
    its([:retweet_count]) { should eq 1 }
    its([:remote_image_url]) { should eq "http://p.twimg.com/A6u7_sdCUAAQXmK.jpg" }

    context "when tweet does not have media array with :type => 'photo'" do
      let(:tweet_dbl) {
        Twitter::Tweet.new(rb_fixture('tweet_w_empty_media_array'))
      }

      # TODO - should probably test url cases in private method get_image_url
      # this just tests that the twitpic case works
      its([:media_url]) { should eq "http://twitpic.com/show/full/b9ripo" }
      its([:media_display_url]) { should eq "http://twitpic.com/b9ripo" }
    end #context
  end

  describe '#expanded_url' do
    let(:tweet_dbl) {
      Twitter::Tweet.new(rb_fixture('tweet_w_empty_media_array'))
    }
    it 'returns truthy when the media array is empty' do
      tweet_processor.expanded_url(tweet_dbl)
        .should be_true
    end
    it 'returns a url when it exists' do
      tweet_processor.expanded_url(tweet_dbl)
        .should eq "http://twitpic.com/b9ripo"
    end
    it 'returns falsey when the tweet has no image' do
      pending
    end
  end


end

