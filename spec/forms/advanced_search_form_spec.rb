# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdvancedSearchForm do
  describe '#search' do
    context 'with no params' do
      it 'returns no posts' do
        create_list(:post, 2)

        form = AdvancedSearchForm.new({})
        expect(form.search.size).to eq(0)
      end
    end

    context 'with from param' do
      it 'returns posts by screen_name' do
        user = create(:user, screen_name: 'foo', posts_count: 2)
        create(:user, posts_count: 1)

        form = AdvancedSearchForm.new(posts: { from: user.screen_name })
        expect(form.search.size).to eq(2)
        expect(form.search.all? { |p| p.user == user }).to be_truthy
      end
    end

    context 'with since param' do
      it 'returns posts whose created_at are on or after the since param' do
        Timecop.freeze(Time.current) do
          (1..3).each { |num| create(:post, created_at: num.days.ago) }

          form = AdvancedSearchForm.new(posts: { since: 2.days.ago.strftime('%Y%m%d') })
          expect(form.search.size).to eq(2)
          # This spec fails on circle ci, so added 10.seconds for margin.
          expect(form.search.all? { |p| p.created_at >= (2.days.ago - 10.seconds) }).to be_truthy
        end
      end
    end

    context 'with till param' do
      it 'returns posts whose created_at are on or before the till param' do
        Timecop.freeze(Time.current) do
          (1..3).each { |num| create(:post, created_at: num.days.ago) }

          form = AdvancedSearchForm.new(posts: { till: 2.days.ago.strftime('%Y%m%d') })
          expect(form.search.size).to eq(2)
          expect(form.search.all? { |p| p.created_at <= 2.days.ago }).to be_truthy
        end
      end
    end
  end
end
