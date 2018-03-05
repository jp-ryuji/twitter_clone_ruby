# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::PostsController', type: :request do
  include_context 'api'

  describe 'GET /api/v1/users/:user_id/posts/:id' do
    before do
      @user = create(:user, posts_count: 1)
    end

    context 'when the post exists' do
      let(:user) do
        {
          'user' => {
            'data' =>
              {
                'id' => @user.id.to_s,
                'type' => 'users'
              }
          }
        }
      end
      let(:expected_response) do
        {
          'data' => {
            'id' => @post.id.to_s,
            'type' => 'posts',
            'attributes' => {
              'content' => @post.content
            },
            'relationships' => user
          }
        }
      end
      before do
        @user = create(:user, posts_count: 1)
        @post = @user.posts.first
        get "/api/v1/users/#{@user.id}/posts/#{@post.id}"
      end

      it_behaves_like 'http_status_code_200_with_json'
    end

    context 'when the post does not exist' do
      before do
        get "/api/v1/users/#{@user.id}/posts/non_existing_post_id"
      end

      it_behaves_like 'http_status_code_404'
    end
  end
end
