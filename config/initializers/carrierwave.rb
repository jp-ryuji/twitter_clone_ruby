# frozen_string_literal: true

CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false if Rails.env.test? # Speed up test

  config.asset_host = Settings.asset_host.carrierwave

  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY'],
      region:                ENV['AWS_REGION'] || 'ap-northeast-1'
    }
    config.fog_directory  = ENV['AWS_BUCKET']
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.days.to_i}" }

    config.storage :fog
  end
end
