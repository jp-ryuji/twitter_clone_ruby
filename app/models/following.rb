# frozen_string_literal: true

# == Schema Information
#
# Table name: followings
#
#  id                :integer          not null, primary key
#  following_user_id :integer          not null
#  follower_id       :integer          not null
#
# Indexes
#
#  index_followings_on_follower_id_and_following_user_id  (follower_id,following_user_id) UNIQUE
#  index_followings_on_following_user_id                  (following_user_id)
#

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
