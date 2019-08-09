# frozen_string_literal: true

# ref: https://qiita.com/thr3a/items/b921ef73d871dac299eb#%E5%AF%BE%E7%AD%96

class LogrageLogger
  class << self
    def call(attr, **options)
      new.log(attr, **options)
    end

    def logger
      @logger ||= MessageOnlyLogger.new(file)
    end

    def file
      Rails.root.join('log', "lograge_#{Rails.env}.log")
    end

  end

  def log(attr, **options)
    self.class.logger.debug log_attr(attr, **options)
  end

  private

  def default_params
    { time: Time.current }
  end

  def log_attr(attr, **options)
    option = { level: 'fatal' }
    e = options[:error]

    if e && e.is_a?(StandardError)
      option[:exception] = [e.class.name, e.message]
      option[:exception_backtrace] = e.backtrace[0..6]
    end

    default_params
      .merge(payload_at_controller)
      .merge(option)
      .merge(attr)
      .to_json
  end

  def payload_at_controller
    i = binding.callers.index { |b| b.receiver.is_a?(ApplicationController) }
    current_controller = binding.of_caller(i).receiver

    payload = current_controller.instance_eval do
      {}.tap { |h| append_info_to_payload(h) }
    end
    raw_payload = current_controller.instance_eval do
      exceptions = %w(controller action format id authenticity_token utf8)
      {
        controller: self.class.name,
        action:     self.action_name,
        params:     request.filtered_parameters.except(*exceptions),
        format:     request.format.try(:ref),
        method:     request.request_method,
        path:       (request.fullpath rescue 'unknown'),
        ip:         request.remote_ip
      }
    end
    payload.merge(raw_payload)
  rescue
    {}
  end
end

class MessageOnlyLogger < ActiveSupport::Logger
  def call(_severity, _timestamp, _progname, message)
    message
  end
end
