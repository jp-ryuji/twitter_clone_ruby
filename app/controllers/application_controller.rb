class ApplicationController < ActionController::Base
  add_flash_types :success, :error

  protect_from_forgery with: :exception
end
