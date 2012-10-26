Feature: Refresh friends
  In order keep the rubyfriends app up to date

  As a background task
  I want to regularly pull tweets from twitter that have been tagged
    with the relevant hashtags

  Scenario: populate the app with friends
    Given the app knows about 0 friends
    When I manually run the refresh friends task
    Then the app should know about more than 0 friends

  @wip
  Scenario: refresh app with friends every 10 minutes
    Given the app has is populated with a known number of friends
    When I wait 10 minutes
    Then the app should have more friends than it did 10 minutes ago
    # FIXME - this is a terrible test, basically I'm gonna use the recorded
    # VCR session from above, write the code for this part and hopefully
    # someone will have hugged cause it's friday somewhere right now
    # then we'll use timecop to fake 10 minutes passing
    # of course, if you delete the vcr recorded session, you'll need to really
    # wait for an update. God forbid it's not friday or no one is hugging
    # (the test data comes from friday hug, as does much of the code for
    # syncing)
