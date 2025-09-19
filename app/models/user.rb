# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                              :bigint(8)        not null, primary key
#  email                           :string           not null
#  crypted_password                :string
#  salt                            :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  name                            :string(20)
#  screen_name                     :string(15)       not null
#  code                            :string
#
# Indexes
#
#  index_users_on_code                  (code) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name)
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_screen_name           (screen_name) UNIQUE
#

require_relative '../value_objects/email'
require_relative '../value_objects/screen_name'

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :following_relations, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
  has_many :following_users, through: :following_relations, source: :following_user

  has_many :followed_relations, class_name: 'Following', foreign_key: 'following_user_id', dependent: :destroy
  has_many :followers, through: :followed_relations, source: :follower

  has_many :posts, dependent: :destroy

  before_validation :normalize_fields

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :screen_name, presence: true, uniqueness: { case_sensitive: false }
  validates :screen_name, exclusion: { in: UNAVAILABLE_SCREEN_NAMES }, allow_blank: true
  validates :name, length: { maximum: 20 }, allow_blank: true

  # Use value objects for validation
  validates_each :email do |record, attr, value|
    Email.new(value) if value.present?
  rescue ArgumentError
    record.errors.add(attr, 'is invalid')
  end

  validates_each :screen_name do |record, attr, value|
    ScreenName.new(value) if value.present?
  rescue ArgumentError
    record.errors.add(attr, 'is invalid')
  end

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

  def register
    Code.new(self, :code).assign_value
    save
  end

  private

  def normalize_fields
    self.email = email.downcase if email
    self.screen_name = screen_name.downcase if screen_name
  end
end
