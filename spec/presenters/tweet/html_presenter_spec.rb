require 'spec_helper'

describe Tweet::HtmlPresenter do
  subject { presenter }

  let(:presenter) { described_class.new tweet }
  let(:tweet) {
    Tweet.new tweet_id: "263515718753079296",
      tweet_text: "at @SteelCityRuby with @coreyhaines - one of my favorite #rubyfriends http://t.co/cyL9StoS",
      username: "joshsusser",
      media_url: "http://p.twimg.com/A6gyJmlCUAA9Il2.jpg",
      image: "A6gyJmlCUAA9Il2.jpg",
      media_display_url: "pic.twitter.com/cyL9StoS"
  }

  its(:url) { should == tweet.media_display_url }
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
end
