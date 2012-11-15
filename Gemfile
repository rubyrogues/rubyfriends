source :rubygems

gem 'rails', '3.2.8'

gem 'carrierwave'
gem 'fog'
gem 'haml-rails'
gem 'jquery-rails'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'rmagick'
gem 'rails_config', '0.2.5'
gem 'thin'
gem 'twitter'

gem 'tweetstream'

group :assets do
  gem 'bootstrap-sass', '~> 2.1.0.0'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'
  gem 'sass-rails', '~> 3.2.3'
  gem 'susy'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'dalli'
  gem 'pg'
end

group :development do
  gem 'foreman'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :test do
  gem 'activerecord-nulldb-adapter',
      :git => "git://github.com/avdi/nulldb.git"
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'growl'
  gem 'guard', '1.4.0'
  gem 'guard-cucumber'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'listen'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rspec-fire'
  gem 'rspec-given'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end
