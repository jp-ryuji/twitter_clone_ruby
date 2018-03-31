# frozen_string_literal: true

require 'csv'

class CsvExporterBase
  def initialize(records)
    @records = records
  end

  def export
    # NOTE: The encoding is for the Japanese environment.
    encoding = Encoding::Windows_31J
    rows = CSV.generate(row_sep: "\r\n", headers: self.class::COLUMNS, write_headers: true, force_quotes: true) do |csv|
      # NOTE: find_each is used here because @records could be thousands of records. If there's no such concern, use each instead.
      @records.find_each do |record|
        csv << parse_record(record).fetch_values(*self.class::COLUMNS)
      end
    end

    rows.encode(encoding, invalid: :replace, undef: :replace)
  end

  private

  def parse_record(_record)
    raise NotImplementedError, "#{__method__} should be implemented"
  end
end
