require 'spec_helper'

describe Tweet::FeedPresenter do
  subject { feed_presenter }

  let(:feed_presenter) { described_class.new tweet }
  let(:tweet) {
    Tweet.new tweet_id: "263515718753079296",
      tweet_text: "at @SteelCityRuby with @coreyhaines - one of my favorite #rubyfriends http://t.co/cyL9StoS",
      username: "joshsusser",
      media_url: "http://p.twimg.com/A6gyJmlCUAA9Il2.jpg",
      image: "A6gyJmlCUAA9Il2.jpg",
      media_display_url: "pic.twitter.com/cyL9StoS"
  }

  its(:author) { should == "@joshsusser" }
  its(:url) { should == tweet.media_display_url }
  its(:username) { should == "@joshsusser" }

  describe "#content" do
    subject(:content) { feed_presenter.content }

    it "contains the tweet's text" do
      should match /#{tweet.tweet_text}/
    end

    it "contains an image tag with the image" do
      should match /<img /
      should match /src="#{tweet.media_url}"/
    end
  end

  describe "#title" do
    subject(:title) { feed_presenter.title }

    it "begins with the username" do
      title.starts_with?("@joshsusser: at @SteelCityRuby with").should be_true
    end

    it "truncates to 50 characters" do
      should have(50).characters
    end
  end
end
