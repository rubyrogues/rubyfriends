desc "Refresh the app with friends from twitter"
task :refresh_tweets => :environment do
  TweetUtility.refresh_tweets
end

desc "Refresh tweets every minute"
task :refresh_tweets_worker => :environment do
  loop do
    TweetUtility.refresh_tweets
    # Rake::Task[:refresh_tweets].invoke
    puts "Sleeping for 60 seconds..."
    sleep 60
  end
end
