Around('@domain_and_gui') do |scenario, block|
  ENV['USE_GUI'] = '1'
  block.call

  ENV['USE_GUI'] = nil
  block.call
end