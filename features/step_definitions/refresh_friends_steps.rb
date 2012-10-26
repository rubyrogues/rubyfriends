# new code
class RubyfriendsApp
  def friends
    Friend.all
  end

  def refresh_friends
    HugAppScript.update_friends
  end
end

# support code
def rubyfriends_app
  @rubyfriends_app ||= RUBYFRIENDS_APP
end

def populate_app
  refresh_friends(cassette: 'populate_friends')
end

def refresh_friends(options = {})
  VCR.use_cassette(options.fetch(:cassette),
                   :preserve_exact_body_bytes => true,
                   :match_requests_on => [:method]) do
    rubyfriends_app.refresh_friends
  end
end

# populate manually
Given /^the app knows about (#{CAPTURE_A_NUMBER}) friends$/ do |expected_count|
  rubyfriends_app.friends.count.should eq expected_count
end

When /^I manually run the refresh friends task$/ do
  # refresh_friends(cassette: 'populate_friends')
  populate_app
end

Then /^the app should know about more than (#{CAPTURE_A_NUMBER}) friends$/ do |expected_count|
  rubyfriends_app.friends.count.should > expected_count
end

# refresh every 10 min
Given /^the app has is populated with a known number of friends$/ do
  populate_app
  @original_populated_friends_count = rubyfriends_app.friends.count
end

When /^I wait 10 minutes$/ do
  # Timecop.travel(Time.now + 10.minutes)
  # sleep(10.minutes)
  refresh_friends(cassette: false)
end

Then /^the app should have more friends than it did 10 minutes ago$/ do
  rubyfriends_app.friends.count.should > @original_populated_friends_count
end