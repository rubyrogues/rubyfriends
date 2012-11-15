require_relative 'spec_helper_lite'

require 'active_record'

databases = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(databases['test'])

# NULLDB, where you at?!