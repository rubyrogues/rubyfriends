Feature: Refresh tweets
  In order keep the rubyfriends app up to date

  As a background task
  I want to regularly pull tweets from twitter that have been tagged
    with the relevant hashtags

  @gui
  Scenario: populate the app with tweets from twitter rest api
    Given the app knows about 0 tweets
    When I manually run the refresh tweets task
    Then the app should know about more than 0 tweets