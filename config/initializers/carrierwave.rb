CarrierWave.configure do |config|
  if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'carrierwave'

    config.storage = :s3
    config.s3_access_key_id = ENV['AWS_ACCESS_KEY_ID']
    config.s3_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    config.s3_bucket = ENV['S3_BUCKET_NAME']
  else
    config.storage = :file
  end
end