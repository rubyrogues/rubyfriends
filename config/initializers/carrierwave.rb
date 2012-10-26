if Rails.env.test? || Rails.env.cucumber? # store on disk, no processing
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
elsif Rails.env.development? # use my own bucket
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                            # required
      :aws_access_key_id      => Settings.aws.access_key_id,       # required
      :aws_secret_access_key  => Settings.aws.secret_access_key,   # required
      :region                 => 'us-west-1'                       # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = Settings.aws.bucket_name               # required
    # config.fog_host       = 'https://assets.example.com'         # optional, defaults to nil
    # config.fog_public     = false                                # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'} # optional, defaults to {}
  end
elsif Rails.env.production? # for use with heroku, ENV vars know bucket
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                            # required
      :aws_access_key_id      => ENV['s3_access_key_id'],          # required
      :aws_secret_access_key  => ENV['s3_secret_access_key'],      # required
      :region                 => 'us-west-1'                       # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = ENV['s3_bucket']

    # heroku doesn't allow saving in public, so save in tmp
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
else
  fail 'Add your rails env to the carrierwave intializer'
end