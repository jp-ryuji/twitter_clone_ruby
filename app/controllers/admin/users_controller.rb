# frozen_string_literal: true

module Admin
  class UsersController < Admin::BaseController
    # NOTE: Using concern is not necessary here because only this controller needs the feature. This is an example.
    # NOTE: Common names for cocern modules are ...er or ...able. No strict rule though.
    include CsvImporter
    include CsvExporter

    before_action :set_user, only: %i[show edit update destroy]

    def index
      @admin_users_search_form = Admin::UsersSearchForm.new(search_params)
      @users = @admin_users_search_form.search.page(params[:page])
    end

    def show; end

    def new
      @user = User.new
    end

    def edit; end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to admin_users_url, notice: "User (#{@user.screen_name}) was successfully created."
      else
        render :new
      end
    end

    def update
      if @user.update(user_params)
        redirect_to admin_users_url, notice: "User (#{@user.screen_name}) was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_url, notice: "User (#{@user.screen_name}) was successfully destroyed."
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :screen_name)
    end

    def search_params
      return {} if params[:admin_users_search_form].blank?

      params.require(:admin_users_search_form).permit(Admin::UsersSearchForm::PARAMS)
    end
  end
end
