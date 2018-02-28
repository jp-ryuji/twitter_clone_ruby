# frozen_string_literal: true

module Admin
  class UsersSearchForm
    include Virtus.model
    include ActiveModel::Model
    # NOTE: This module is included for sanitize_sql_like that is for partial search (like search).
    include ActiveRecord::Sanitization::ClassMethods

    attribute :search_text, String

    PARAMS = [:search_text].freeze

    # NOTE: Full-text search engine (e.g. Elasticsearch) or pg_trgm/pg_bigm on PostgreSQL should be considered against huge data.
    def search
      query = User.all
      if search_text.present?
        query = query.where(
          'users.email like :search_text OR users.screen_name like :search_text',
          search_text: "%#{sanitize_sql_like(search_text)}%"
        )
      end

      query.order(created_at: :desc)
    end
  end
end
