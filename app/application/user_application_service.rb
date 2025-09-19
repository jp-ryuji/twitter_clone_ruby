# frozen_string_literal: true

require_relative '../value_objects/email'
require_relative '../value_objects/screen_name'

class UserApplicationService
  def register_user(email:, screen_name:, password:)
    # Validate inputs using value objects
    email_obj = Email.new(email)
    screen_name_obj = ScreenName.new(screen_name)

    # Check if user already exists
    existing_user = User.find_by(email: email_obj.to_s) || User.find_by(screen_name: screen_name_obj.to_s)
    raise ArgumentError, 'User with this email or screen name already exists' if existing_user

    # Create user through the model
    user = User.new(email: email_obj.to_s, screen_name: screen_name_obj.to_s, password: password)
    user.register
    user
  end

  def get_user_by_screen_name(screen_name)
    User.find_by(screen_name: screen_name)
  end

  def get_users_not_following(follower_id, page = 1)
    User.not_following_users(User.find(follower_id)).page(page)
  end
end
