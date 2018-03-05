# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::BaseController
      before_action :set_user, only: %i[show]

      def index
        # TODO: Normally there're lots of records, so pagination should be considered then.
        users = User.all

        # NOTE: include: [] is for not including relationships data.
        render json: users, include: []
      end

      def show
        # NOTE: Make sure how to use Conditional Get and Cache.
        #   See more on Conditional Get: https://apidock.com/rails/ActionController/ConditionalGet/stale%3F
        # rubocop:disable Style/GuardClause
        if stale?(last_modified: @user.updated_at.utc)
          cache_options = { compress: true, expires_in: 24.hours, race_condition_ttl: 10 }
          Rails.cache.fetch("#{@user.cache_key}/#{__method__}", cache_options) do
            render json: @user
          end
        end
        # rubocop:enable Style/GuardClause
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
