class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :following_relations, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
  has_many :followees, through: :following_relations, source: :followee

  has_many :followed_relations, class_name: 'Following', foreign_key: 'followee_id', dependent: :destroy
  has_many :followers, through: :followed_relations, source: :follower

  has_many :posts, dependent: :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  SCREEN_NAME_REGEXP = /\A[0-9a-zA-Z_]{1,15}\z/i

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX }, allow_blank: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :screen_name, presence: true, uniqueness: true
  validates :screen_name, format: { with: SCREEN_NAME_REGEXP }, allow_blank: true
  validates :name, length: { maximum: 20 }, allow_blank: true

  def follow(other)
    followees << other
  end

  def unfollow(other)
    followees.destroy(other)
  end

  def following?(other)
    User.joins(:following_relations).where('followings.followee_id = ? AND followings.follower_id = ?', other.id, id).any?
  end
end
