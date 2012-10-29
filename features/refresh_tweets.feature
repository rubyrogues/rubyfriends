Feature: Refresh tweets
  In order keep the rubyfriends app up to date

  As a background task
  I want to regularly pull tweets from twitter that have been tagged
    with the relevant hashtags

  Scenario: populate the app with tweets
    Given the app knows about 0 tweets
    When I manually run the refresh tweets task
    Then the app should know about more than 0 tweets

  @pending
  Scenario: refresh app with tweets every 10 minutes
    Given the app has is populated with a known number of tweets
    When I wait 10 minutes
    Then the app should have more tweets than it did 10 minutes ago
    # FIXME - indeterminate and maybe useless test
