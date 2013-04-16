require 'spec_helper'

describe "tweets" do
  let(:tweet) {
    Tweet.new tweet_text: "Hi!", published: true, published_at: Time.now
  }

  before :each do
    tweet.save
  end

  it "responds to html" do
    visit tweets_path

    page.should have_content("Hi!")
  end

  it "responds to atom" do
    visit tweets_path(format: :atom)

    page.should have_content("Hi!")
  end

  context "with a Twitter username" do
    before :each do
      tweet.tweet_text = "@rubyfriends"
    end

    it "does not escape our anchor tags" do
      visit tweets_path

      page.should_not have_content("&lt;")
    end
  end
end
