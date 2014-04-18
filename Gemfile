source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '~> 4.0.0'

# image uploads
gem 'carrierwave'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'fog'
# Fog dependency for AWS keys
gem 'unf'
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

# javascript
gem 'coffee-rails', '~> 4.0.0'
gem "compass-rails", '~> 1.1', '>= 1.1.5'
gem 'sass-rails', '~> 4.0.0'
# twitter boostrap converted to sass files
gem 'bootstrap-sass', '~> 2.1.0.0'
# fluid grids
gem 'susy'
# compressor
gem 'uglifier', '>= 1.3.0'

group :production do
  def require_false_unless(gem_name, condition)
    if condition
      gem gem_name
    else
      gem gem_name, :require => false
    end
  end
  # memcached
  gem 'memcachier'
  gem 'dalli'

  # db
  gem 'pg'
  # heroku addon
  # gem 'carrierwave' # must come first
  require_false_unless('cloudinary', !!ENV['CLOUDINARY_URL'])

  # required by heroku
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
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
  gem 'cucumber-rails', require: false, github: 'cucumber/cucumber-rails' # see https://github.com/cucumber/cucumber-rails/pull/253#issuecomment-23400508
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
