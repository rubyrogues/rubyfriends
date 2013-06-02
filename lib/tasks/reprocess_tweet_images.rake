task :reprocess_tweet_images => :environment do
  Tweet.find_each do |tweet|
    tweet.image.recreate_versions!
  end
end
