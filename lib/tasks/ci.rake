desc 'Rake task for continuous integration'
task :ci => ['bootstrap:ci', :environment] do
  Rake::Task['default'].invoke
end
