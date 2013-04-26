desc 'Set up the app for developer use'
task :bootstrap => ['bootstrap:dev']
namespace :bootstrap do
  desc 'For continuous integration'
  task :ci => [:copy_config_files]
  task :dev => [:copy_config_files, :setup_db]

  desc 'Copy any config files that need copying'
  task :copy_config_files do
    cp 'config/application.example.yml', 'config/application.yml'
  end

  task :setup_db => [:environment, 'db:migrate', 'db:test:prepare']

end
