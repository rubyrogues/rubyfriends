module KnowsApp
  class UI < RubyfriendsApp
    include Capybara::DSL
    def tweets_count
      visit '/'
      all('ul#smiles-list li').count
    end
  end
end
World(KnowsApp)

module WorldHelper
  attr_writer :rubyfriends_app
  def rubyfriends_app
    if ENV['USE_GUI']
      rubyfriends_app = KnowsApp::UI.new
    else
      rubyfriends_app = RubyfriendsApp.new
    end
  end
end
World(WorldHelper)



Given /^the app knows about (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  rubyfriends_app.tweets_count.should eq expected_count
end

When /^I manually run the refresh tweets task$/ do
  VCR.use_cassette('refresh_tweets',
                   :preserve_exact_body_bytes => true) do
    rubyfriends_app.refresh_tweets
  end
end

Then /^the app should know about more than (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  rubyfriends_app.tweets_count.should > expected_count
end