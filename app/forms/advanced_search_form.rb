# frozen_string_literal: true

# NOTE: This code is a subspecies of Extract Form Objects at https://codeclimate.com/blog/7-ways-to-decompose-fat-activerecord-models/
class AdvancedSearchForm
  include Virtus.model
  include ActiveModel::Model

  def self.model_name
    # FIXME: Maybe the class name at line 3 should be PostsSearchForm instead of AdvancedSearchForm.
    ActiveModel::Name.new(self, nil, 'PostsSearchForm')
  end

  FORM_FIELDS = %i[
    from
    since
    till
  ].freeze

  FORM_FIELDS.each do |f|
    attribute f, String
  end

  def initialize(params)
    @posts_search_form = params[:posts_search_form] || {}
    FORM_FIELDS.each { |f| send("#{f}=", @posts_search_form[f]) }
  end

  # TODO: Full text search should be considered for keyword search.
  # rubocop:disable Metrics/AbcSize
  def search
    return Post.none if @posts_search_form.empty?

    query = Post.includes(:user).order('posts.created_at desc')
    query = query.joins(:user).where(users: { screen_name: from }) if from.present?
    query = query.where('posts.created_at >= ?', Time.zone.parse(since)) if since.present?
    query = query.where('posts.created_at < ?', Time.zone.parse(till) + 1.day) if till.present?
    query
  end
  # rubocop:enable  Metrics/AbcSize
end
