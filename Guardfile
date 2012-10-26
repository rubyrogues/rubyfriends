guard 'cucumber', :cli => '--profile guard',
                  :run_all => { :cli => "--profile default" } do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$}) { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'features'
  }

  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { 'features' }
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})         { 'features' }
  watch(%r{app/helpers/.+\.rb})                      { 'features' }
  watch(%r{config/routes.rb})                        { 'features' }

  watch(%r{^lib/(.+)\.rb$})                          { 'features' }
end