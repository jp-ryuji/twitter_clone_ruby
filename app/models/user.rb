class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :following_relations, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
  has_many :following_users, through: :following_relations, source: :following_user

  has_many :followed_relations, class_name: 'Following', foreign_key: 'following_user_id', dependent: :destroy
  has_many :followers, through: :followed_relations, source: :follower

  has_many :posts, dependent: :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  SCREEN_NAME_REGEXP = /\A[0-9a-zA-Z_]{1,15}\z/i

  before_validation -> {
    self.email = self.email.downcase
    self.screen_name = self.screen_name.downcase
  }

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: EMAIL_REGEX }, allow_blank: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :screen_name, presence: true, uniqueness: { case_sensitive: false }
  validates :screen_name, format: { with: SCREEN_NAME_REGEXP }, allow_blank: true
  validates :screen_name, exclusion: { in: UNAVAILABLE_SCREEN_NAMES }, allow_blank: true
  validates :name, length: { maximum: 20 }, allow_blank: true

  def self.not_following_users(myself)
    where.not(id: myself.id)
      .where.not(id: myself.following_user_ids)
  end

  def follow(other)
    following_users << other
  end

  def unfollow(other)
    following_users.destroy(other)
  end
end
