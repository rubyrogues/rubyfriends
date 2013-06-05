require 'spec_helper'

describe Tweet::HtmlPresenter do
  subject { presenter }

  let(:presenter) { described_class.new tweet }
  let(:tweet_link) {
    link = 'http://t.co/cyL9StoS'
    ExpandUrl.stub(:expand_url).with(link).and_return(link)
    link
  }
  let(:tweet) {
    Tweet.new(tweet_id: "263515718753079296",
      tweet_text: "at @SteelCityRuby with @coreyhaines - one of my favorite #rubyfriends #{tweet_link}",
      username: "joshsusser",
      media_url: "http://p.twimg.com/A6gyJmlCUAA9Il2.jpg",
      image: "A6gyJmlCUAA9Il2.jpg",
      media_display_url: "pic.twitter.com/cyL9StoS"
      )
  }

  its(:username) { should == "@joshsusser" }

  describe "#text" do
    subject(:text) { presenter.text }

    it "links twitter hashtags" do
      should include '<a href="http://twitter.com/search?q=%23rubyfriends">#rubyfriends</a>'
    end

    it "links twitter usernames" do
      should include '<a href="http://twitter.com/SteelCityRuby">@SteelCityRuby</a>'
      should include '<a href="http://twitter.com/coreyhaines">@coreyhaines</a>'
    end

    it "sanitizes html" do
      tweet.tweet_text = "this < is > a & test"

      should == "this &lt; is &gt; a &amp; test"
    end
  end

  describe "#url" do
    subject(:url) { presenter.url }

    it "builds a status url" do
      tweet.username = 'foo'
      tweet.tweet_id = 1
      should == 'https://twitter.com/foo/status/1'
    end
  end
end
