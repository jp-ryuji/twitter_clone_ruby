# frozen_string_literal: true

class UsersCsvExporter < CsvExporterBase
  # NOTE: Override the method for the includes.
  def initialize(records)
    @records = records.includes(:posts)
  end

  COLUMNS = %w[
    email
    screen_name
    posts
  ].freeze

  private

  # NOTE: A constant can't be private although it's defined here since it's only used by a private method.
  COLUMNS_FROM_METHOD = %w[
    posts
  ].freeze

  def parse_record(user)
    COLUMNS.each_with_object({}) do |column, h|
      h[column] =
        if COLUMNS_FROM_METHOD.include?(column)
          send(column, user)
        else
          user[column]
        end
    end
  end

  # NOTE: It is unlikely that outputting posts (tweet) with | separated. This is an example.
  def posts(user)
    posts = user.posts
    # NOTE: As for the difference between present?, empty?, any?, exists?, see the following page.
    #   https://semaphoreci.com/blog/2017/03/14/faster-rails-how-to-check-if-a-record-exists.html
    return '' if posts.empty?
    posts.pluck(:content).join('|')
  end
end
