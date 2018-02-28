# frozen_string_literal: true

class UsersCsvExporter < CsvExporterBase
  def initialize(records)
    # NOTE: You might need to use includes here.
    @records = records
  end

  COLUMNS = %w[
    email
    screen_name
    posts
  ].freeze

  private

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
    return '' unless posts.exists?
    posts.pluck(:content).join('|')
  end
end
