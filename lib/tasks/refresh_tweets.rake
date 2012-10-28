desc "Refresh the app with friends from twitter"
task :refresh_tweets => :environment do
  RUBYFRIENDS_APP.refresh_tweets
end