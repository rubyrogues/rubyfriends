require_relative '../spec_helper_db'

require "rspec/mocks/standalone"
stub_const("MOUNT_IMAGE_UPLOADER", true)

require_relative '../../app/models/rubyfriends_app'



describe RubyfriendsApp do
  subject(:app) { described_class.new(->{entries}) }
  let(:entries) { [] }

  its(:title) { should_not be_nil }
  its(:subtitle) { should_not be_nil }
  its(:default_hashtag) { should_not be_nil }
  its(:hashtags) { should be_an(Array) }

  its(:entries) { should be_empty }
  its(:entries_count) { should be 0 }

  describe '#hashtags' do
    context '#when #default_hashtag is plural' do
      it 'provides a 2 element - 1 plural, 1 singular' do
        app.default_hashtag = "RubyFriends"
        app.hashtags.should eq ["RubyFriends", "RubyFriend"]
      end
    end #context
    context 'when #default_hashtag is singular' do
      it 'provides a 1 element array with the singular version' do
        app.default_hashtag = "RubyFriend"
        app.hashtags.should eq ["RubyFriend"]
      end
    end #context
  end

  describe '#new_entry' do
    let(:initialized_entry_dbl) { OpenStruct.new }
    before do
      app.entry_initializer = ->{ initialized_entry_dbl }
    end

    it 'returns a new object that will play the role of an entry' do
      app.new_entry.should eq initialized_entry_dbl
    end

    it "sets the entry's app reference to itself" do
      app.new_entry.app.should eq app
    end

    it 'accepts attributes on behalf of the entry initializer' do
      entry_initializer_dbl = double('entry_initializer').as_null_object
      app.entry_initializer = entry_initializer_dbl

      entry_initializer_dbl.should_receive(:call).with(foo: 'bar')

      app.new_entry(foo: 'bar')
    end
  end

  describe '#add_entry' do
    it 'adds the entry to the app' do
      entry_dbl = double('entry')
      entry_dbl.should_receive(:save)
      app.add_entry(entry_dbl)
    end
  end


  context 'tweet processing' do
    # rspec-fire says those constants don't have a method name call! Method Object?
    # Maybe I am making too many expectations anyway
    let(:tweet_refresher_dbl) { double(TweetRefresher).as_null_object }
    let(:tweet_streamer_dbl)  { double(TweetStreamer).as_null_object  }
    let(:tweet_processor_dbl) { double(TweetProcessor).as_null_object }

    before do
      app.tweet_refresher = tweet_refresher_dbl
      app.tweet_streamer  = tweet_streamer_dbl
      app.tweet_processor = tweet_processor_dbl

      rubyfriends_app = fire_double('RubyfriendsApp', hashtags: ['RubyFriends'])
      stub_const("RUBYFRIENDS_APP", rubyfriends_app)
    end

    describe '#refresh_tweets' do
      xit 'sets the tweet processors app reference to itself' do
        app.refresh_tweets.app.should eq app
      end
      it 'initializes tweet refresher with a tweet processor' do
        tweet_processor_dbl.should_receive(:call).ordered
          .with(app)
        tweet_refresher_dbl.should_receive(:call).ordered
          .with(tweet_processor_dbl)
        tweet_refresher_dbl.should_receive(:refresh).ordered

        app.refresh_tweets
      end
    end

    describe '#persist_tweetstream' do
      xit 'sets the tweet processors app reference to itself' do
        app.refresh_tweets.app.should eq app
      end
      it 'initializes tweet refresher with a tweet processor' do
        tweet_processor_dbl.should_receive(:call).ordered
          .with(app)
        tweet_streamer_dbl.should_receive(:call).ordered
          .with(tweet_processor_dbl)
        tweet_streamer_dbl.should_receive(:stream).ordered

        app.persist_tweetstream
      end
    end
  end #context


end
