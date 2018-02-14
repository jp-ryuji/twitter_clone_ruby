# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    user = login(*params.values_at(:email, :password, :remember_me))
    if user
      redirect_back_or_to root_url, notice: 'Logged in'
    else
      flash.now[:alert] = 'Email or password was invalid'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: 'Logged out'
  end
end
