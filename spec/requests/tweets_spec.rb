require 'spec_helper'

describe "tweets" do
  before :each do
    Tweet.create! tweet_text: "Hi!", published: true, published_at: Time.now
  end

  it "responds to html" do
    visit tweets_path

    page.should have_content("Hi!")
  end

  it "responds to atom" do
    visit tweets_path

    page.should have_content("Hi!")
  end
end
