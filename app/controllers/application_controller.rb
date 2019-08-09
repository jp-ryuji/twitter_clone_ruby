# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :error

  before_action :require_login
  protect_from_forgery with: :exception

  protected

  def append_info_to_payload(payload)
    super
    payload[:ip]         = request.remote_ip
    payload[:referer]    = request.referer
    payload[:user_agent] = request.user_agent

    payload[:user_id]    = current_user&.id

    if @exception.present?
      payload[:exception_object] ||= @exception
      payload[:exception] ||= [@exception.class, @exception.message]
    end
  end

  def not_authenticated
    redirect_to login_url, alert: 'You need to login first to access this page.'
  end
end
