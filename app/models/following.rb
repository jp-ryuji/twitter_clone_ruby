# frozen_string_literal: true

class Following < ApplicationRecord
  belongs_to :following_user, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  validates :following_user_id, presence: true
  validates :follower_id, presence: true
  validates :follower_id, uniqueness: { scope: :following_user_id }
  validate :disallow_to_follow_myself

  private

  def disallow_to_follow_myself
    errors.add(:base, 'Followoing myself is not allowed.') if following_user_id == follower_id
  end
end
