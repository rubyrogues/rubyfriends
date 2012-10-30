if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['s3_access_key_id'],
      :aws_secret_access_key  => ENV['s3_secret_access_key'],
      :region                 => 'us-west-1'
    }
    config.fog_directory  = ENV['s3_bucket']

    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
