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

class UserSerializer < ActiveModel::Serializer
  attributes :email, :screen_name

  has_many :posts
end
