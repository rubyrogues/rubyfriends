task :reprocess_tweet_images => :environment do
  RUBYFRIENDS_APP.tweets.each do |tweet|
    tweet.image.recreate_versions!
  end
end