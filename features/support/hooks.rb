Before('@gui') do |scenario, block|
  ENV['USE_GUI'] = '1'
end