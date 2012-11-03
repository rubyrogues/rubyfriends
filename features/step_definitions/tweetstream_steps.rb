When /^I persist the tweetstream to the app$/ do
  rubyfriends_app.persist_tweetstream
end

Then /^the app should fill with tweets$/ do
  pending # express the regexp above with the code you wish you had
end