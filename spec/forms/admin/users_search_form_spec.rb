# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersSearchForm do
  describe '#search' do
    context 'with no params' do
      before do
        create_list(:user, 2)
      end

      it 'returns all users' do
        form = Admin::UsersSearchForm.new({})
        expect(form.search.size).to eq(2)
      end
    end

    context 'with existing email' do
      before do
        @user = create(:user, email: 'foo@example.com')
        create(:user, email: 'bar@example.com')
      end

      it 'returns matched users' do
        form = Admin::UsersSearchForm.new(search_text: @user.email[1..-2])
        expect(form.search.size).to eq(1)
        expect(form.search.first.email).to eq(@user.email)
      end
    end

    context 'with existing screen_name' do
      before do
        @user = create(:user, screen_name: 'abcdefg')
        create(:user, screen_name: 'hijklmn')
      end

      it 'returns matched users' do
        form = Admin::UsersSearchForm.new(search_text: @user.screen_name[1..-2])
        expect(form.search.size).to eq(1)
        expect(form.search.first.screen_name).to eq(@user.screen_name)
      end
    end

    context 'with non-existing screen_name ' do
      before do
        create(:user, screen_name: 'abcdefg')
        create(:user, screen_name: 'hijklmn')
      end

      it 'returns no users' do
        form = Admin::UsersSearchForm.new(search_text: 'xyz')
        expect(form.search.size).to eq(0)
      end
    end
  end
end
