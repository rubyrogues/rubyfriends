require 'spec_helper'

describe TweetMediaExtractor do

  describe '.is_image?' do
    supported_image_urls = %w[
      twitpic.com yfrog.com instagr.am img.ly ow.ly d.pr .jpg .jpeg .gif .png
    ].each do |image_url|
      it "returns true for supported url #{image_url}" do
        subject.is_image?(image_url).should be_true
      end
    end

    it 'returns false for unsupported url' do
      subject.is_image?('http://un-supported-url.com').should be_false
    end
  end

  describe '.get_image_url' do
    it 'returns the image url when given a direct image url' do
      image_url = 'http://awesome-pics.com/photo.jpg'
      subject.get_image_url(image_url).should == image_url
    end

    it 'returns the image url when given a twitpic url' do
      tweet_url = 'http://twitpic.com/IMAGEID'
      image_url = 'http://twitpic.com/show/full/IMAGEID'

      subject.get_image_url(tweet_url).should == image_url
    end

    it 'returns the image url when given a yfrog url' do
      tweet_url = 'http://twitter.yfrog.com/IMAGEID'
      image_url = 'http://yfrog.com/IMAGEID:medium'

      subject.get_image_url(tweet_url).should == image_url
    end

    it 'returns the image url when given an instagram url' do
      tweet_url = 'http://instagr.am/p/IMAGEID'
      image_url = 'http://instagr.am/p/IMAGEID/media?size=m'

      subject.get_image_url(tweet_url).should == image_url
    end

    it 'returns the image url when given an ow.ly url' do
      tweet_url = 'http://ow.ly/i/IMAGEID'
      image_url = 'http://static.ow.ly/photos/normal/IMAGEID.jpg'

      subject.get_image_url(tweet_url).should == image_url
    end

    it 'returns the image url when given a droplr url' do
      tweet_url = 'http://d.pr/i/IMAGEID'
      image_url = 'http://d.pr/i/IMAGEID+'

      subject.get_image_url(tweet_url).should == image_url
    end
  end
end
