unless ENV['GUARD_NOTIFY'] # Only run simplecov with Rake
  require 'simplecov'
  SimpleCov.start :rails
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require_relative 'spec_helper_lite'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

RSpec::Fire.configure do |config|
  config.verify_constant_names = true
end
