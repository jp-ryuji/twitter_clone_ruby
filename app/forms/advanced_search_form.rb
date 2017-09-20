class AdvancedSearchForm
  include Virtus.model
  include ActiveModel::Model

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Posts')
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
    posts = params[:posts] || {}
    FORM_FIELDS.each { |f| send("#{f}=", posts[f]) }
  end

  # TODO Full text search should be considered for keyword search.
  def search
    query = Post.all
    query = query.joins(:user).where('users.screen_name = ?', from) if from.present?
    query = query.where('posts.created_at >= ?', Time.zone.parse(since)) if since.present?
    query = query.where('posts.created_at < ?', Time.zone.parse(till) + 1.day) if till.present?
    query
  end
end

