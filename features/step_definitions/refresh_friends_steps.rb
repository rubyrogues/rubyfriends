require 'twitter'


class RubyfriendsApp
  def friends
    Friend.all
  end

  def update_friends
    fail 'here'
  end
end


def rubyfriends_app
  @rubyfriends_app ||= RubyfriendsApp.new
end

Given /^the app knows about (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  rubyfriends_app.friends.count.should eq expected_count
end

When /^manually run the update friends task$/ do
  rubyfriends_app.update_friends
end

Then /^the app should know about more than (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  pending # express the regexp above with the code you wish you had
end