# frozen_string_literal: true

require_relative '../value_objects/post_content'

class PostApplicationService
  def create_post(user_id:, content:)
    # Validate content using value object
    content_obj = PostContent.new(content)

    # Find user
    user = User.find(user_id)

    # Create post through the model
    user.posts.create!(content: content_obj.to_s)
  end

  def get_posts_by_user_id(user_id, page = 1)
    Post.where(user_id: user_id).order(created_at: :desc).page(page)
  end

  def get_posts_by_following_users(follower_id, page = 1)
    Post.posts_by_following_users(User.find(follower_id)).page(page)
  end
end
