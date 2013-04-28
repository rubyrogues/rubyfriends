# support code
def default_hashtags
  ['FridayHugs']
end
TWEET_SEARCHER = TwitterSearch.new(default_hashtags)
def tweet_utility
  @tweet_utility ||= TweetUtility
end

def populate_tweets
  refresh_tweets(cassette: 'populate_tweets')
end

def refresh_tweets(options = {})
  VCR.use_cassette(options.fetch(:cassette),
                   :preserve_exact_body_bytes => true,
                   :match_requests_on => [:method]) do
    tweet_utility.refresh_tweets
  end
end

# populate manually
Given /^the app knows about (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  tweet_utility.total_tweets.should eq expected_count
end

When /^I manually run the refresh tweets task$/ do
  populate_tweets
end

Then /^the app should know about more than (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  tweet_utility.total_tweets.should > expected_count
end

# refresh every 10 min
Given /^the app has is populated with a known number of tweets$/ do
  populate_app
  @original_populated_total_tweets = tweet_utility.total_tweets
end

When /^I wait 10 minutes$/ do
  # Timecop.travel(Time.now + 10.minutes)
  # sleep(10.minutes)
  # refresh_tweets(cassette: 'refresh_tweets')
  tweet_utility.refresh_tweets
end

Then /^the app should have more tweets than it did 10 minutes ago$/ do
  tweet_utility.total_tweets.should > @original_populated_total_tweets
end
