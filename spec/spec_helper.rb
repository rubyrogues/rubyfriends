unless ENV['GUARD_NOTIFY'] # Only run simplecov with Rake
  require 'simplecov'
  SimpleCov.start :rails
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = true
  config.order = :random
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
