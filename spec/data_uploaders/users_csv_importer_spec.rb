# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersCsvImporter, type: :model do
  let(:file) { fixture_file_upload('files/user.csv', 'text/csv') }
  let(:line_count) do
    content = File.read(file.path)
    # Count the number of lines (newline characters + 1)
    content.count("\n") + 1
  end

  describe 'create' do
    context 'when a record with the same email does not exist in the database' do
      it 'creates records' do
        expect(User.count).to eq(0)

        UsersCsvImporter.new(file).import
        # Expect to create records for each data row (line_count - 1 for header)
        expect(User.count).to eq(line_count - 1)
      end
    end
  end

  describe 'update' do
    context 'when a record with the same email exists in the database' do
      before do
        lines_in_csv = File.read(file.path).split("\n")
        # Expect 3 lines total (header + 2 data rows)
        expect(line_count).to eq(3)
        expect(lines_in_csv[1]).to include('test1@example.com')
        expect(lines_in_csv[2]).to include('test2@example.com')

        @user  = create(:user, email: 'test1@example.com', password: 'password', screen_name: 'test1_in_db')
        @user2 = create(:user, email: 'test2@example.com', password: 'password', screen_name: 'test2_in_db')
        expect(User.count).to eq(2)
      end

      it 'updates the record' do
        UsersCsvImporter.new(file).import
        expect(User.count).to eq(2)
        @user.reload # NOTE: Reload is needed to update the object
        expect(@user.screen_name).to eq('testuser1') # Updated from CSV
      end
    end
  end

  describe 'delete' do
    context 'when a record with delete flag true given' do
      let(:file_for_deletion) { fixture_file_upload('files/user_deletion.csv', 'text/csv') }

      before do
        expect(User.count).to eq(0)
        UsersCsvImporter.new(file).import
        # Should have created 2 users (line_count - 1 for header)
        expect(User.count).to eq(line_count - 1)
      end

      it 'deletes specified lines' do
        UsersCsvImporter.new(file_for_deletion).import
        # Should have deleted 1 user, leaving 1
        expect(User.count).to eq((line_count - 1) - 1)
        expect(User.first.email).to eq('test2@example.com')
      end
    end
  end
end
