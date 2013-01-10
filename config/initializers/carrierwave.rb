CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                               # required
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],            # required
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],        # required
      :region                 => 'us-east-1'                          # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME']                     # required
    config.fog_public     = true                                      # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}    # optional, defaults to {}
    config.asset_host     = 'https://s3.amazonaws.com/tuckeredin'     #'http://www.tuckered.in'            # optional, defaults to nil

    # non-fog way of storing with s3?
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'carrierwave'
    #config.storage = :s3
    #config.s3_access_key_id = ENV['AWS_ACCESS_KEY_ID']
    #config.s3_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    #config.s3_bucket = ENV['S3_BUCKET_NAME']
  else
    config.storage = :file
    #config.enable_processing = false
  end
end
