# frozen_string_literal: true

require 'rails_helper'
require 'csv'

RSpec.describe UsersCsvExporter, type: :model do
  describe '.export' do
    let(:header) { %w[email screen_name posts] }

    it 'exports a file encoded by Windows-31J' do
      # NOTE: Make sure how transient works. See spec/factories/users.rb.
      create(:user, email: 'test1@example.com', screen_name: 'test1', posts_count: 2)
      create(:user, email: 'test2@example.com', screen_name: 'test2')

      csv_lines = UsersCsvExporter.new(User.all).export
      expect(csv_lines.encoding).to eq(Encoding::Windows_31J)

      records = CSV.parse(csv_lines.encode(Encoding::UTF_8))
      expect(records.size).to eq(3)
      # NOTE: Check how splat operator, *, works yourself if you're not sure. (google it!!).
      expect(records.first).to include(*header)
      expect(records.second).to include('test1')
      expect(records.second.last).to match(/.+\|.+/) # Check the separater, |, with posts is included.
      expect(records.third).to include('test2')
    end
  end
end
