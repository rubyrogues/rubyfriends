desc "Refresh the app with friends from twitter"
task :refresh_friends => :environment do
  RUBYFRIENDS_APP.refresh_friends
end