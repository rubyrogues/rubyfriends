source 'https://rubygems.org'

gem 'rails', '~> 3.2.0'

# image uploads
gem 'carrierwave'
gem 'fog'
# image manipulation
gem 'mini_magick'
# view templating
gem 'haml-rails'
# javascript
gem 'jquery-rails'
# pagination
gem 'kaminari'
# diagnostics
gem 'newrelic_rpm'
# web server
gem 'thin'
# twitter api
gem 'twitter'
# cron jobs
gem 'whenever', require: false

group :assets do
  # twitter boostrap converted to sass files
  gem 'bootstrap-sass', '~> 2.1.0.0'
  # javascript
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'
  gem 'sass-rails', '~> 3.2.3'
  # fluid grids
  gem 'susy'
  # compressor
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  def require_false_unless(gem_name, condition)
    if condition
      gem gem_name
    else
      gem gem_name, :require => false
    end
    gem gem_name
  end
  # memcached
  require_false_unless('memcachier', !!ENV['MEMCACHIER_USERNAME'])
  gem 'dalli'

  # db
  gem 'pg'
  # heroku addon
  # gem 'carrierwave' # must come first
  require_false_unless('cloudinary', !!ENV['CLOUDINARY_URL'])
end

group :development do
  gem 'foreman'
end

group :development, :test do
  # configuration
  gem 'figaro'
  # spec testing
  gem 'rspec-rails'
  # db
  gem 'sqlite3'
end

group :test do
  # acceptance testing
  gem 'cucumber-rails', require: false
  # clear db
  gem 'database_cleaner'
  # notifier
  gem 'growl'
  # autotest
  gem 'guard', '1.4.0'
  gem 'guard-cucumber'
  gem 'guard-livereload'
  gem 'guard-rspec'
  # platform-agnostic program launcher
  gem 'launchy'
  # change notifier
  gem 'listen'
  # better repl
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  # file system event watcher
  gem 'rb-fsevent', '~> 0.9.1'
  # test coverage
  gem 'simplecov'
  # time manipulation for tests
  gem 'timecop'
  # record and replay test web requests
  gem 'vcr'
  # mock web requests
  gem 'webmock'
end
