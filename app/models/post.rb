# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :content, length: { in: 1..140 }, allow_blank: true

  # TODO: Might want to use key value store? (redis?)
  def self.posts_by_following_users(follower)
    joins(user: :followed_relations)
      .includes(:user)
      .where('followings.follower_id = ?', follower.id)
      .order('posts.created_at DESC')
  end
end
