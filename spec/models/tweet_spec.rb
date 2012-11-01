require 'spec_helper_nulldb'

require "rspec/mocks/standalone"
stub_const("MOUNT_IMAGE_UPLOADER", true)

require_relative '../../app/models/tweet'

describe Tweet do
  let(:tweet) { Tweet.new }

  it 'supports reading and writing an app reference' do
    app_dbl = double('app')
    tweet.app = app_dbl
    tweet.app.should eq app_dbl
  end

  describe '#publish' do
    let(:app_dbl) { fire_double('RubyfriendsApp') }
    before do
      tweet.app = app_dbl
    end

    it 'adds the tweet to the app' do
      app_dbl.should_receive(:add_entry)
      tweet.publish
    end

    it 'returns truthy on success' do
      app_dbl.stub(:add_entry) { tweet }
      tweet.publish.should be_true
    end
  end

  describe '#published_at' do

    context 'before publishing' do
      it 'is blank' do
        tweet.published_at.should be_nil
      end
    end

    context 'after publishing' do
      let(:now) { DateTime.parse("2011-09-11T02:56") }
      before do
        clock = double('clock')
        clock.stub(:now) { now }
        tweet.stub(:app) { double('app').as_null_object }
        tweet.publish(clock)
      end

      it 'is a datetime' do
        expect(tweet.published_at.is_a?(ActiveSupport::TimeWithZone) ||
               tweet.published_at.is_a?(DateTime)).to be_true,
               "published at must be a datetime of some kind"
      end

      it 'is the current time' do
        tweet.published_at.should eq now
      end
    end

  end

end
