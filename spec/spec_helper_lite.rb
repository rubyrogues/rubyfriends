ENV["RAILS_ENV"] ||= 'test'

Dir["./spec/support/**/*.rb"].each {|f| require f}
require 'rspec/fire'
require 'rspec/given'
require 'pry'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.alias_example_to :fit, :focus => true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.order = "random"

  config.include RSpec::Fire
end

# i guess rspec rails has its own fixture_path
def fixture_dir
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.read(fixture_dir + '/' + file)
end

def rb_fixture(file)
  file = file + '.rb'
  eval(fixture(file))
end


def stub_module(full_name, &block)
  stub_class_or_module(full_name, Module)
end

def stub_class(full_name, &block)
  stub_class_or_module(full_name, Class)
end

def stub_class_or_module(full_name, kind, &block)
  full_name.to_s.split(/::/).inject(Object) do |context, name|
    begin
      # Give autoloading an opportunity to work
      context.const_get(name)
    rescue NameError
      # Defer substitution of a stub module/class to the last possible
      # moment by overloading const_missing. We use a module here so
      # we can "stack" const_missing definitions for various
      # constants.
      mod = Module.new do
        define_method(:const_missing) do |missing_const_name|
          if missing_const_name.to_s == name.to_s
            value = kind.new
            const_set(name, value)
            value
          else
            super(missing_const_name)
          end
        end
      end
      context.extend(mod)
    end
  end
end