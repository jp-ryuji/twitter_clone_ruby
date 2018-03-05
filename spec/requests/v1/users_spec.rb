# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::UsersController', type: :request do
  include_context 'api'

  describe 'GET /api/v1/users' do
    context 'without params' do
      let(:expected_response) do
        {
          data: User.all.map do |user|
            {
              id: user.id.to_s,
              type: 'users',
              attributes: {
                email: user.email,
                screen_name: user.screen_name
              },
              relationships: { posts: { data: [] } }
            }
          end
        }
      end
      before do
        create_list(:user, 2)
        get '/api/v1/users'
      end

      it_behaves_like 'http_status_code_200_with_json'
    end
  end

  describe 'GET /api/v1/users/:email' do
    context 'when the user exists' do
      let(:posts) do
        {
          posts: {
            data:
              @user.posts.map do |post|
                {
                  id: post.id.to_s,
                  type: 'posts'
                }
              end
          }
        }
      end
      let(:expected_response) do
        {
          data: {
            id: @user.id.to_s,
            type: 'users',
            attributes: {
              email: @user.email,
              screen_name: @user.screen_name
            },
            relationships: posts
          }
        }
      end
      before do
        @user = create(:user, posts_count: 2)
        get "/api/v1/users/#{@user.id}"
      end

      it_behaves_like 'http_status_code_200_with_json'
    end

    context 'when the user does not exist' do
      before do
        get '/api/v1/users/non_existing_user_id'
      end

      it_behaves_like 'http_status_code_404'
    end
  end
end
