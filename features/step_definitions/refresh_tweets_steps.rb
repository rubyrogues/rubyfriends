# support code
def rubyfriends_app
  @rubyfriends_app ||= RUBYFRIENDS_APP
end

def populate_tweets
  refresh_tweets(cassette: 'populate_tweets')
end

def refresh_tweets(options = {})
  VCR.use_cassette(options.fetch(:cassette),
                   :preserve_exact_body_bytes => true,
                   :match_requests_on => [:method]) do
    rubyfriends_app.refresh_tweets
  end
end

Before do
  rubyfriends_app.default_hashtag = 'FridayHugs'
end

# populate manually
Given /^the app knows about (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  rubyfriends_app.tweets_count.should eq expected_count
end

When /^I manually run the refresh tweets task$/ do
  populate_tweets
end

Then /^the app should know about more than (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  rubyfriends_app.tweets_count.should > expected_count
end

# refresh every 10 min
Given /^the app has is populated with a known number of tweets$/ do
  populate_app
  @original_populated_tweets_count = rubyfriends_app.tweets_count
end

When /^I wait 10 minutes$/ do
  # Timecop.travel(Time.now + 10.minutes)
  # sleep(10.minutes)
  # refresh_tweets(cassette: 'refresh_tweets')
  rubyfriends_app.refresh_tweets
end

Then /^the app should have more tweets than it did 10 minutes ago$/ do
  rubyfriends_app.tweets_count.should > @original_populated_tweets_count
end