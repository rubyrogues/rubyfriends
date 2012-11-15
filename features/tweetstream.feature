Feature: Tweetstream
  In order to keep the app up to date

  As a background task
  I want to continuously stream tweets into the app

  # @wip
  Scenario: persist tweetstream
     When I persist the tweetstream to the app
     Then the app should fill with tweets