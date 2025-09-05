# frozen_string_literal: true

require 'csv'
require 'nkf'

class CsvImporterBase
  attr_reader :errors

  def initialize(file)
    @file = file
    @errors = ActiveModel::Errors.new(self)
  end

  # NOTE: The number of lines to detect encoding
  NUMBER_OF_LINES_TO_DETECT_ENCODING = 100

  # TODO: The header should be checked on production normally.
  def import_base
    CSV.foreach(@file.path, encoding: detect_encoding, headers: true) do |row|
      next if row.blank?

      yield ActiveSupport::HashWithIndifferentAccess.new(row)
    end
  end

  private

  def detect_encoding
    File.open(@file.path) do |file|
      NUMBER_OF_LINES_TO_DETECT_ENCODING.times.each do
        begin
          guessed_encoding = NKF.guess(file.readline).to_s
        rescue EOFError
          # Do nothing
        end

        # NOTE: 'BOM|UTF-8' is upward compatibile with 'UTF-8'.
        return 'BOM|UTF-8' if guessed_encoding == 'UTF-8'
        # NOTE: Shift_JIS and Windows-31J(CP932) are for the Japanese characters. Windows-31J is a superset of Shift_JIS.
        return 'Windows-31J' if guessed_encoding == 'Shift_JIS'
        return guessed_encoding if guessed_encoding != 'US-ASCII'
      end
    end

    'BOM|UTF-8'
  end
end
