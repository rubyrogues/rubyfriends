Rails.application.routes.draw do

  mount TweetEngine::Engine => "/tweet_engine"
end
