class ApplicationController < ActionController::Base
  add_flash_types :success, :error

  protect_from_forgery with: :exception

  protected
    def not_authenticated
      redirect_to login_url, alert: 'You need to login first to access this page.'
    end
end
