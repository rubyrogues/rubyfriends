$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tweet_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tweet_engine"
  s.version     = TweetEngine::VERSION
  s.authors     = ["RubyRogues"]
  s.email       = ["github@benjaminfleischer.com"]
  s.license     = 'MIT'
  s.homepage    = ""
  s.summary     = "Summary of TweetEngine."
  s.description = "DO: Description of TweetEngine."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency 'twitter'
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
