desc "Refresh the app with friends from twitter"
task :refresh_tweets => :environment do
  RUBYFRIENDS_APP.refresh_tweets
end

desc "Refresh tweets every minute"
task :refresh_tweets_worker => :environment do
  loop do
    RUBYFRIENDS_APP.refresh_tweets
    puts "Sleeping for 60 seconds..."
    sleep 60
  end
end
