# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :error

  before_action :require_login
  protect_from_forgery with: :exception

  protected

  def append_info_to_payload(payload)
    super
    append_request_info_to_payload(payload)
    append_user_info_to_payload(payload)
    append_exception_info_to_payload(payload)
  end

  def not_authenticated
    redirect_to login_url, alert: 'You need to login first to access this page.'
  end

  private

  def append_request_info_to_payload(payload)
    payload[:ip] = request.remote_ip
    payload[:referer] = request.referer
    payload[:user_agent] = request.user_agent
  end

  def append_user_info_to_payload(payload)
    payload[:user_id] = current_user&.id
  end

  def append_exception_info_to_payload(payload)
    return unless @exception.present?

    payload[:exception_object] ||= @exception
    payload[:exception] ||= [@exception.class, @exception.message]
  end
end
