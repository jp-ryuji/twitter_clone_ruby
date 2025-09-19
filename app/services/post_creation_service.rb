# frozen_string_literal: true

require_relative '../value_objects/post_content'

class PostCreationService
  def self.call(user:, content:)
    new.call(user: user, content: content)
  end

  def call(user:, content:)
    # Validate content using value object
    content_obj = PostContent.new(content)

    # Create post
    user.posts.create!(content: content_obj.to_s)
  end
end
