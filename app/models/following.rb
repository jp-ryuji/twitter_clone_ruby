class Following < ApplicationRecord
  belongs_to :followee, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  validates :followee_id, presence: true
  validates :follower_id, presence: true
  validates_uniqueness_of :follower_id, scope: :followee_id
  validate :disallow_to_follow_myself

  private
    def disallow_to_follow_myself
      if followee_id == follower_id
        errors.add(:base, 'Followoing myself is not allowed.')
      end
    end
end
