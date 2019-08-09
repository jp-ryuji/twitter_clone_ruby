# frozen_string_literal: true

Rails.application.configure do
  config.lograge.enabled                 = true
  config.lograge.base_controller_class   = ['ActionController::API', 'ActionController::Base']
  config.lograge.keep_original_rails_log = true
  config.lograge.logger                  = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"
  config.lograge.formatter               = Lograge::Formatters::Json.new

  config.lograge.custom_options = lambda do |event|
    exceptions = %w(controller action format id authenticity_token utf8)

    data = {
      time:       Time.current.iso8601,
      level:      'info',
      user_id:    event.payload[:user_id],
      ip:         event.payload[:ip],
      referer:    event.payload[:referer],
      user_agent: event.payload[:user_agent],
      params:     event.payload[:params].except(*exceptions),
    }

    if event.payload[:exception]
      data[:level]               = 'fatal'
      data[:exception]           = event.payload[:exception]
      data[:exception_backtrace] = event.payload[:exception_object].backtrace[0..6]
    end

    data
  end
end
