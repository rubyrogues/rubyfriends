if Rails.env.production?
  Twitter.configure do |config|
    config.consumer_key = ENV['consumer_key']
    config.consumer_secret = ENV['consumer_secret']
    config.oauth_token = ENV['oauth_token']
    config.oauth_token_secret = ENV['oauth_token_secret']
  end

  TweetStream.configure do |config|
    config.consumer_key       = ENV['consumer_key']
    config.consumer_secret    = ENV['consumer_secret']
    config.oauth_token        = ENV['oauth_token']
    config.oauth_token_secret = ENV['oauth_token_secret']
    config.auth_method        = :oauth
  end
end

if Rails.env.development? or Rails.env.test? or Rails.env.cucumber?
  Twitter.configure do |config|
    config.consumer_key = Settings.twitter.consumer_key
    config.consumer_secret = Settings.twitter.consumer_secret
    config.oauth_token = Settings.twitter.oauth_token
    config.oauth_token_secret = Settings.twitter.oauth_token_secret
  end

  TweetStream.configure do |config|
    config.consumer_key       = Settings.twitter.consumer_key
    config.consumer_secret    = Settings.twitter.consumer_secret
    config.oauth_token        = Settings.twitter.oauth_token
    config.oauth_token_secret = Settings.twitter.oauth_token_secret
    config.auth_method        = :oauth
  end
end