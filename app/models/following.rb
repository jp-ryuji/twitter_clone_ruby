class Following < ApplicationRecord
  belongs_to :following_user, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  validates :following_user_id, presence: true
  validates :follower_id, presence: true
  validates_uniqueness_of :follower_id, scope: :following_user_id
  validate :disallow_to_follow_myself

  private
    def disallow_to_follow_myself
      if following_user_id == follower_id
        errors.add(:base, 'Followoing myself is not allowed.')
      end
    end
end
