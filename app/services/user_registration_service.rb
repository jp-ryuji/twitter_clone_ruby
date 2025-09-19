# frozen_string_literal: true

require_relative '../value_objects/email'
require_relative '../value_objects/screen_name'

class UserRegistrationService
  def self.call(user_params:, password:)
    new.call(user_params: user_params, password: password)
  end

  def call(user_params:, password:)
    # Validate inputs using value objects
    email_obj = Email.new(user_params[:email])
    screen_name_obj = ScreenName.new(user_params[:screen_name])

    # Check if user already exists
    existing_user = User.find_by(email: email_obj.to_s) || User.find_by(screen_name: screen_name_obj.to_s)
    raise ArgumentError, 'User with this email or screen name already exists' if existing_user

    # Create user
    user = User.new(user_params.merge(password: password))
    user.save!
    user
  end
end
