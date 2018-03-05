# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::BaseController
      before_action :set_post, only: %i[show]

      def show
        # rubocop:disable Style/GuardClause
        if stale?(last_modified: @post.updated_at.utc)
          cache_options = { compress: true, expires_in: 24.hours, race_condition_ttl: 10 }
          Rails.cache.fetch("#{@post.cache_key}/#{__method__}", cache_options) do
            render json: @post
          end
        end
        # rubocop:enable Style/GuardClause
      end

      private

      def set_post
        @post = User.find(params[:user_id]).posts.find(params[:id])
      end
    end
  end
end
