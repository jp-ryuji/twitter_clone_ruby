# frozen_string_literal: true

require_relative '../application/user_application_service'
require_relative '../application/post_application_service'
require_relative '../application/following_application_service'

class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[follow unfollow]

  def show
    user_app_service = UserApplicationService.new
    post_app_service = PostApplicationService.new

    @user = user_app_service.get_user_by_screen_name(params[:screen_name])
    @posts = post_app_service.get_posts_by_user_id(@user.id, params[:page])
  end

  def new
    @user = ::User.new
  end

  def create
    @user = register_new_user

    if @user.errors.any?
      render :new
    else
      auto_login(@user)
      redirect_to root_url, notice: 'Signed up'
    end
  end

  private

  def register_new_user
    user_app_service = UserApplicationService.new

    begin
      user_app_service.register_user(
        email: params[:user][:email],
        screen_name: params[:user][:screen_name],
        password: params[:user][:password]
      )
    rescue ArgumentError => e
      user = ::User.new(user_params)
      user.errors.add(:base, e.message)
      user
    end
  end

  def who_to_follow
    user_app_service = UserApplicationService.new
    @users = user_app_service.get_users_not_following(current_user.id, params[:page])
  end

  # TODO: follow and unfollow should be done by ajax.
  # TODO: fallback_location in follow and unfollow can be changed.
  def follow
    following_app_service = FollowingApplicationService.new
    following_app_service.follow_user(current_user.id, @user.id)
    redirect_back(fallback_location: root_url, notice: "Following #{@user.email}")
  end

  def unfollow
    following_app_service = FollowingApplicationService.new
    following_app_service.unfollow_user(current_user.id, @user.id)
    redirect_back(fallback_location: root_url, notice: "Unfollowed #{@user.email}")
  end

  def following_users
    following_app_service = FollowingApplicationService.new
    @following_users = following_app_service.get_following_users(current_user.id, params[:page])
  end

  def followers
    following_app_service = FollowingApplicationService.new
    @followers = following_app_service.get_followers(current_user.id, params[:page])
    @following_user_ids = current_user.following_user_ids
  end

  def user_params
    params.require(:user).permit(:email, :screen_name, :password)
  end

  def set_user
    @user = ::User.find(params[:user_id])
  end
end
